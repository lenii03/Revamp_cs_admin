import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';

void main() {
  const storageName = 'cs_admin_session';
  final file = File(
    '${Platform.environment['USERPROFILE']}\\Documents\\$storageName.gs',
  );
  final raw = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final keyText =
      'R4PxiU3h8YoIrQVowBxM36ZCcENeZ4s1${storageName}qVowBxM36ZCcE'
          .substring(0, 32);
  final encrypter = Encrypter(AES(Key.fromUtf8(keyText)));
  final iv = IV.fromUtf8('1234567890123456');
  String decrypt(String value) =>
      encrypter.decrypt(Encrypted.fromBase64(value), iv: iv);

  for (final entry in raw.entries) {
    if (decrypt(entry.key) != 'bGlzdFBXRE5QSU4=') continue;
    final queue = jsonDecode(decrypt(entry.value.toString()));
    final items = queue['ListEmailForgotPINAndPassword'] as List;
    stdout.writeln('count=${items.length}');
    for (var index = 0; index < items.length; index++) {
      stdout.writeln('$index ${jsonEncode(items[index])}');
    }
  }
}
