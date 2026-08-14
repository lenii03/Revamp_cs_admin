import 'package:el_csadmin/features/auto_update/data/models/file_hash_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';

import 'auto_update_event.dart';
import 'auto_update_state.dart';
import '../../domain/repositories/auto_update_repository.dart';

class AutoUpdateBloc extends Bloc<AutoUpdateEvent, AutoUpdateState> {
  final AutoUpdateRepository repository;
  List<Map<String, String>> localHashes = [];
  List<FileHashModel> serverHashes = [];
  List<FileHashModel> filesToUpdate = [];
  List<FileHashModel> filesToDownload = [];

  AutoUpdateBloc({required this.repository}) : super(AutoUpdateInitial()) {
    on<CheckForUpdateStarted>((event, emit) async {
      localHashes.clear();
      serverHashes.clear();
      filesToUpdate.clear();
      filesToDownload.clear();

      emit(AutoUpdateLoading("Membaca file lokal di komputer..."));
      try {
        final exePath = Platform.resolvedExecutable;
        final appDir = Directory(File(exePath).parent.path);
        final tempRoot = p.normalize(p.join(appDir.path, 'temp'));
        final allEntities = appDir.listSync(recursive: true);

        for (final entity in allEntities) {
          if (entity is! File || p.isWithin(tempRoot, entity.path)) continue;

          final bytes = await entity.readAsBytes();
          final fileHash = md5.convert(bytes).toString();
          final relativePath = p.relative(entity.path, from: appDir.path);
          final normalizedPath = relativePath.replaceAll('\\', '/');
          localHashes.add({"fileName": normalizedPath, "fileHash": fileHash});
        }
      } catch (error) {
        emit(AutoUpdateFailure("Gagal membaca file lokal: $error"));
        return;
      }

      emit(AutoUpdateLoading("Mengambil data hash dari API server..."));
      final result = await repository.getListHashBinaryFile();
      String? serverError;
      result.fold(
        (error) => serverError = error.toString(),
        (serverFiles) => serverHashes = serverFiles,
      );
      if (serverError != null) {
        emit(AutoUpdateFailure(serverError!));
        return;
      }

      emit(AutoUpdateLoading("Membandingkan file lokal dengan server..."));
      for (final serverFile in serverHashes) {
        final localFile = localHashes.firstWhere(
          (local) =>
              local["fileName"] == _normalizeRelativePath(serverFile.fileName),
          orElse: () => {},
        );
        if (localFile.isEmpty ||
            !_hashesMatch(localFile["fileHash"] ?? '', serverFile.fileHash)) {
          filesToUpdate.add(serverFile);
        }
      }

      if (filesToUpdate.isEmpty) {
        emit(AutoUpdateUpToDate());
        return;
      }

      emit(AutoUpdateLoading("Memeriksa file pembaruan di folder temp..."));
      try {
        for (final file in filesToUpdate) {
          final tempFile = File(_resolveTempPath(file.fileName));
          if (!await tempFile.exists()) {
            filesToDownload.add(file);
            continue;
          }

          final tempHash = await _calculateFileHash(tempFile);
          if (!_hashesMatch(tempHash, file.fileHash)) {
            filesToDownload.add(file);
          }
        }
      } catch (error) {
        emit(AutoUpdateFailure("Gagal memeriksa folder temp: $error"));
        return;
      }

      if (filesToDownload.isEmpty) {
        emit(AutoUpdateReadyToInstall());
      } else {
        emit(
          AutoUpdateAvailable(
            List.unmodifiable(filesToUpdate),
            List.unmodifiable(filesToDownload),
          ),
        );
      }
    });

    on<DownloadUpdateStarted>((event, emit) async {
      for (int i = 0; i < event.filesToUpdate.length; i++) {
        final file = event.filesToUpdate[i];
        late final String savePath;
        try {
          savePath = _resolveTempPath(file.fileName);
        } catch (error) {
          emit(AutoUpdateFailure(error.toString()));
          return;
        }
        final fileDir = Directory(p.dirname(savePath));
        if (!await fileDir.exists()) {
          await fileDir.create(recursive: true);
        }

        emit(AutoUpdateDownloading(i + 1, event.filesToUpdate.length, 0.0));

        final result = await repository.downloadBinaryFile(
          fileName: file.fileName,
          savePath: savePath,
          isCompressPackage: true,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final progress = received / total;
              if (!isClosed) {
                add(
                  AutoUpdateUpdateProgress(
                    i + 1,
                    event.filesToUpdate.length,
                    progress,
                  ),
                );
              }
            }
          },
        );
        if (result.isLeft()) {
          String errorMessage = 'Terjadi kesalahan';
          result.fold((l) => errorMessage = l.toString(), (r) => null);

          emit(
            AutoUpdateFailure(
              'Gagal mengunduh ${file.fileName}: $errorMessage',
            ),
          );
          return;
        }

        final downloadedFile = File(savePath);
        if (!await downloadedFile.exists()) {
          emit(
            AutoUpdateFailure(
              'File ${file.fileName} tidak ditemukan setelah download.',
            ),
          );
          return;
        }

        final downloadedHash = await _calculateFileHash(downloadedFile);
        if (!_hashesMatch(downloadedHash, file.fileHash)) {
          await downloadedFile.delete();
          emit(
            AutoUpdateFailure(
              'Hash ${file.fileName} tidak sesuai dengan server. Silakan coba lagi.',
            ),
          );
          return;
        }
      }

      emit(AutoUpdateReadyToInstall());
    });
    on<InstallUpdateStarted>((event, emit) async {
      emit(
        AutoUpdateLoading("Menjalankan updater dan memulai ulang aplikasi..."),
      );
      try {
        final exePath = Platform.resolvedExecutable;
        final appDir = File(Platform.resolvedExecutable).parent.path;
        final appExeName = p.basename(exePath);
        final tempUpdater = File(_resolveTempPath('update.exe'));
        final installedUpdater = File(p.join(appDir, 'update.exe'));
        final updaterFile = await tempUpdater.exists()
            ? tempUpdater
            : installedUpdater;
        if (!await updaterFile.exists()) {
          emit(
            AutoUpdateFailure(
              'update.exe tidak ditemukan. Jalankan pemeriksaan kembali.',
            ),
          );
          return;
        }

        await Process.start(
          'cmd',
          ['/c', 'start', '""', 'update.exe', '\\temp', appExeName],
          workingDirectory: appDir,
          mode: ProcessStartMode.detached,
        );
        emit(AutoUpdateSuccess());
        await Future<void>.delayed(const Duration(milliseconds: 500));
        exit(0);
      } catch (error) {
        emit(AutoUpdateFailure("Gagal menjalankan update.exe: $error"));
      }
    });
    on<AutoUpdateUpdateProgress>((event, emit) {
      emit(
        AutoUpdateDownloading(
          event.currentFileIndex,
          event.totalFiles,
          event.progress,
        ),
      );
    });
  }

  String _resolveTempPath(String fileName) {
    final appDir = File(Platform.resolvedExecutable).parent.path;
    final tempRoot = p.normalize(p.join(appDir, 'temp'));
    final normalizedName = fileName.replaceAll('/', Platform.pathSeparator);
    final candidate = p.normalize(p.join(tempRoot, normalizedName));
    if (p.isAbsolute(normalizedName) ||
        (candidate != tempRoot && !p.isWithin(tempRoot, candidate))) {
      throw FormatException('Path file update tidak valid: $fileName');
    }
    return candidate;
  }

  String _normalizeRelativePath(String fileName) {
    return fileName.replaceAll('\\', '/');
  }

  Future<String> _calculateFileHash(File file) async {
    final bytes = await file.readAsBytes();
    return md5.convert(bytes).toString();
  }

  bool _hashesMatch(String first, String second) {
    return first.trim().toLowerCase() == second.trim().toLowerCase();
  }
}
