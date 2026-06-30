import 'package:dio/dio.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sessionService = locator<SessionService>();
    final token = sessionService.read(SessionKey.token);

    options.headers.addAll({
      "Access-Control-Allow-Origin": "*",
      "Accept": "*/*",
      if (token.isNotEmpty) "Authorization": "Bearer $token",
    });

    print(
      "🚀 MENGIRIM :: ${options.method} :: ${options.baseUrl}${options.path}",
    );
    print("📦 DATA :: ${options.data}");
    print("🔑 TOKEN :: Bearer $token");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      "❌ ERROR DIO :: ${err.requestOptions.method} :: ${err.requestOptions.baseUrl}${err.requestOptions.path}",
    );
    print(
      "❌ STATUS :: ${err.response?.statusCode} :: ${err.response?.statusMessage}",
    );
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      "✅ SUKSES :: ${response.requestOptions.method} :: ${response.requestOptions.baseUrl}${response.requestOptions.path}",
    );
    return super.onResponse(response, handler);
  }
}
