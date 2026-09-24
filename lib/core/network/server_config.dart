import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerConfig {
  static const String _hostKey = 'server_host';
  static const String _portKey = 'server_port';

  static Future<void> saveServer(String host, String port) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_hostKey, host.trim());
    await prefs.setString(_portKey, port.trim());
  }

  static Future<String> getHost() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_hostKey) ?? '';
  }

  static Future<String> getPort() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_portKey) ?? '';
  }

  static Future<String> getBaseUrl() async {
    final host = await getHost();
    final port = await getPort();

    if (host.isEmpty) return '';

    return port.isNotEmpty
        ? 'http://$host:$port/csAdmin/'
        : 'http://$host/csAdmin/';
  }

  static Future<bool> checkConnection({
    String? host,
    String? port,
    Duration timeout = const Duration(seconds: 3),
  }) async {
    final targetHost = (host ?? await getHost()).trim();
    final targetPort = (port ?? await getPort()).trim();

    if (targetHost.isEmpty) return false;

    final url = targetPort.isNotEmpty
        ? 'http://$targetHost:$targetPort/csAdmin/'
        : 'http://$targetHost/csAdmin/';

    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: timeout,
          receiveTimeout: timeout,
          sendTimeout: timeout,
        ),
      );
      await dio.get(url);
      return true;
    } on DioException catch (e) {
      if (e.response != null || e.type == DioExceptionType.badResponse) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
