import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:get_storage/get_storage.dart';

class SessionService {
  late GetStorage _box;
  bool useEncryption = true;

  final _iv = IV.fromUtf8('1234567890123456');
  late Encrypter _encrypt;

  Future<SessionService> init(String name) async {
    await GetStorage.init(name);
    _box = GetStorage(name);

    final key = 'R4PxiU3h8YoIrQVowBxM36ZCcENeZ4s1${name}qVowBxM36ZCcE'
        .substring(0, 32);
    _encrypt = Encrypter(AES(Key.fromUtf8(key)));

    return this;
  }

  String encode(String value) {
    if (useEncryption) {
      if (value.isEmpty) return '';
      return _encrypt.encrypt(value, iv: _iv).base64;
    }
    return value;
  }

  String decode(String? value) {
    if (value != null && value.isNotEmpty) {
      try {
        final encValue = Encrypted.fromBase64(value);
        return _encrypt.decrypt(encValue, iv: _iv);
      } catch (e) {
        return '';
      }
    }
    return '';
  }

  Future<void> write(String key, String value) async {
    await _box.write(encode(key), encode(value));
  }

  String read(String key) {
    return decode(_box.read(encode(key)) ?? '');
  }

  void remove(String key) {
    _box.remove(encode(key));
  }

  T? readDB<T>(String key, T Function(Map<String, dynamic> mapJson) generator) {
    final jsonString = read(key);
    if (jsonString.isNotEmpty) {
      try {
        Map<String, dynamic> mapJson = jsonDecode(jsonString);
        return generator(mapJson);
      } catch (err) {
        return null;
      }
    }
    return null;
  }

  Future<void> writeDB(String key, Map<String, dynamic> data) async {
    String jsonString = jsonEncode(data);
    await write(key, jsonString);
  }
}

class SessionKey {
  static String token = base64.encode("token".codeUnits);
  static String themeMode = base64.encode("themeMode".codeUnits);
  static String loginId = base64.encode("loginId".codeUnits);
  static String baseUrl = base64.encode("baseUrl".codeUnits);
  static String emailSetting = base64.encode("emailSetting".codeUnits);
  static String fileHash = base64.encode("fileHash".codeUnits);
  static String listPwdNPIN = base64.encode("listPWDNPIN".codeUnits);
  static String password = base64.encode("password".codeUnits);
}
