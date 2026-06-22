import 'package:shared_preferences/shared_preferences.dart';

class ServerConfig {
  static const String _hostKey = 'server_host';
  static const String _portKey = 'server_port';

  static Future<void> saveServer(String host, String port) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_hostKey, host);
    await prefs.setString(_portKey, port);
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
}
