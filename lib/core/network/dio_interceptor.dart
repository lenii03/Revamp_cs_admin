import 'package:dio/dio.dart';
import 'token_service.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenService.getToken() ?? '-'; 
    options.headers.addAll({
      "Access-Control-Allow-Origin": "*",
      "Accept": "*/*",
      "Authorization": "Bearer $token",
    });

    print("🚀 MENGIRIM :: ${options.method} :: ${options.baseUrl}${options.path}");
    print("📦 DATA :: ${options.data}");
    print("🔑 TOKEN :: Bearer $token");

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("❌ ERROR DIO :: ${err.requestOptions.method} :: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    print("❌ STATUS :: ${err.response?.statusCode} :: ${err.response?.statusMessage}");
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("✅ SUKSES :: ${response.requestOptions.method} :: ${response.requestOptions.baseUrl}${response.requestOptions.path}");
    return super.onResponse(response, handler);
  }
}