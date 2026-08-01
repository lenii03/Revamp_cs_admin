import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:encrypt/encrypt.dart';

class SendEmailQueueRepository {
  final SessionService _sessionService;
  final List<SendEmailForgotModel> _items = [];
  Future<void> _operationQueue = Future.value();

  SendEmailQueueRepository(this._sessionService);

  List<SendEmailForgotModel> load() {
    final raw = _sessionService.read(SessionKey.listPwdNPIN);
    if (raw.isEmpty) {
      _items.clear();
    } else {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw const FormatException('Format antrean Send Email tidak valid.');
      }

      final rawList = decoded['ListEmailForgotPINAndPassword'];
      _items
        ..clear()
        ..addAll(
          rawList is List
              ? rawList.whereType<Map>().map(
                  (item) => SendEmailForgotModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
              : const [],
        );
    }

    _synchronizeLegacyQueue();
    return List.unmodifiable(_items);
  }

  Future<void> enqueue(SendEmailForgotModel item) {
    return _runExclusive(() async {
      load();
      // Aplikasi lama mempertahankan setiap request, termasuk request berulang.
      _items.insert(0, item);
      await _persist();
      await _writeToLegacyQueue(item);
    });
  }

  Future<List<SendEmailForgotModel>> markAsSent(int index) {
    return _runExclusive(() async {
      load();
      if (index < 0 || index >= _items.length) {
        throw RangeError.index(index, _items, 'index');
      }

      final current = _items[index];
      _items[index] = SendEmailForgotModel(
        actionType: current.actionType,
        loginId: current.loginId,
        email: current.email,
        loginType: current.loginType,
        status: 2,
        requestId: current.requestId,
        source: current.source,
        createdAt: current.createdAt,
      );
      await _persist();
      await _writeToLegacyQueue(_items[index]);
      return List.unmodifiable(_items);
    });
  }

  Future<void> _persist() {
    return _sessionService.writeDB(SessionKey.listPwdNPIN, {
      'ListEmailForgotPINAndPassword': _items
          .map((item) => item.toJson())
          .toList(),
    });
  }

  Future<T> _runExclusive<T>(Future<T> Function() operation) {
    final completer = Completer<T>();
    _operationQueue = _operationQueue.then((_) async {
      try {
        completer.complete(await operation());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  void _synchronizeLegacyQueue() {
    final legacyItems = _readLegacyQueue();
    if (legacyItems.isEmpty) return;

    final newApplicationItems = _items
        .where((item) => item.source == 'new')
        .toList();
    final newItemsByRequestId = {
      for (final item in newApplicationItems)
        if (item.requestId.isNotEmpty) item.requestId: item,
    };
    final currentByIdentity = <String, List<SendEmailForgotModel>>{};
    for (final item in _items.where((item) => item.source != 'new')) {
      currentByIdentity.putIfAbsent(_identity(item), () => []).add(item);
    }

    final synchronized = <SendEmailForgotModel>[];
    for (final legacyItem in legacyItems) {
      final mirroredNewItem = newItemsByRequestId[legacyItem.requestId];
      if (mirroredNewItem != null) {
        // Baris ini adalah salinan kompatibilitas untuk aplikasi lama, bukan
        // request berbeda. Ambil perubahan statusnya tanpa menggandakan baris.
        if (legacyItem.status == 2) mirroredNewItem.status = 2;
        continue;
      }

      final matches = currentByIdentity[_identity(legacyItem)];
      final currentItem = matches != null && matches.isNotEmpty
          ? matches.removeAt(0)
          : null;

      synchronized.add(
        SendEmailForgotModel(
          actionType: legacyItem.actionType,
          loginId: legacyItem.loginId,
          email: legacyItem.email,
          loginType: legacyItem.loginType,
          // Email Send bersifat final; jangan dikembalikan menjadi Pending.
          status: legacyItem.status == 2 || currentItem?.status == 2 ? 2 : 1,
          requestId: currentItem?.requestId ?? '',
          source: 'legacy',
          createdAt: currentItem?.createdAt ?? '',
        ),
      );
    }

    // Request yang dibuat hanya dari aplikasi baru tetap dipertahankan.
    for (final remainingItems in currentByIdentity.values) {
      synchronized.addAll(remainingItems);
    }

    _items
      ..clear()
      ..addAll(newApplicationItems)
      ..addAll(synchronized);
  }

  List<SendEmailForgotModel> _readLegacyQueue() {
    final userProfile = Platform.environment['USERPROFILE'];
    if (userProfile == null || userProfile.isEmpty) return const [];

    for (final storageName in const ['Debug_CS_ADMIN', 'CS_ADMIN']) {
      final file = File('$userProfile\\Documents\\$storageName.gs');
      if (!file.existsSync()) continue;

      try {
        final rawStorage =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        final keyText =
            'R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1${storageName}qVowBXm36ZcCe'
                .substring(0, 32);
        final encrypter = Encrypter(AES(Key.fromUtf8(keyText)));
        final iv = IV.fromUtf8('1234567890123456');

        String decrypt(String value) =>
            encrypter.decrypt(Encrypted.fromBase64(value), iv: iv);

        for (final entry in rawStorage.entries) {
          if (decrypt(entry.key) != SessionKey.listPwdNPIN) continue;

          final decodedQueue = jsonDecode(decrypt(entry.value.toString()));
          if (decodedQueue is! Map) return const [];
          final rawList = decodedQueue['ListEmailForgotPINAndPassword'];
          if (rawList is! List) return const [];

          return rawList
              .whereType<Map>()
              .map(
                (item) => SendEmailForgotModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList();
        }
      } catch (_) {
        continue;
      }
    }
    return const [];
  }

  Future<void> _writeToLegacyQueue(SendEmailForgotModel item) async {
    final userProfile = Platform.environment['USERPROFILE'];
    if (userProfile == null || userProfile.isEmpty) return;

    for (final storageName in const ['Debug_CS_ADMIN', 'CS_ADMIN']) {
      final file = File('$userProfile\\Documents\\$storageName.gs');
      if (!file.existsSync()) continue;

      try {
        final rawStorage =
            jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        final encrypter = _legacyEncrypter(storageName);
        final iv = IV.fromUtf8('1234567890123456');

        String decrypt(String value) =>
            encrypter.decrypt(Encrypted.fromBase64(value), iv: iv);
        String encrypt(String value) => encrypter.encrypt(value, iv: iv).base64;

        String? encryptedQueueKey;
        for (final encryptedKey in rawStorage.keys) {
          if (decrypt(encryptedKey) == SessionKey.listPwdNPIN) {
            encryptedQueueKey = encryptedKey;
            break;
          }
        }

        final queue = <dynamic>[];
        if (encryptedQueueKey != null) {
          final decoded = jsonDecode(
            decrypt(rawStorage[encryptedQueueKey].toString()),
          );
          if (decoded is Map) {
            final existing = decoded['ListEmailForgotPINAndPassword'];
            if (existing is List) queue.addAll(existing);
          }
        } else {
          encryptedQueueKey = encrypt(SessionKey.listPwdNPIN);
        }

        final legacyJson = item.toJson();
        final existingIndex = item.requestId.isEmpty
            ? -1
            : queue.indexWhere(
                (value) =>
                    value is Map &&
                    value['requestId']?.toString() == item.requestId,
              );
        if (existingIndex >= 0) {
          queue[existingIndex] = legacyJson;
        } else {
          // Aplikasi lama menambahkan request baru ke bagian akhir.
          queue.add(legacyJson);
        }

        rawStorage[encryptedQueueKey] = encrypt(
          jsonEncode({'ListEmailForgotPINAndPassword': queue}),
        );
        await file.writeAsString(jsonEncode(rawStorage), flush: true);
      } catch (error) {
        throw FileSystemException(
          'Gagal menyinkronkan antrean ke CS Admin lama: $error',
          file.path,
        );
      }
    }
  }

  Encrypter _legacyEncrypter(String storageName) {
    final keyText =
        'R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1${storageName}qVowBXm36ZcCe'.substring(
          0,
          32,
        );
    return Encrypter(AES(Key.fromUtf8(keyText)));
  }

  String _identity(SendEmailForgotModel item) {
    return '${item.loginId.toLowerCase()}:${item.actionType}';
  }
}
