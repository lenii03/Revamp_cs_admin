import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../injector.dart';
import '../local/session_service.dart';
import '../../core/constants/api_config.dart';
import '../../core/network/server_config.dart';
import 'dio_interceptor.dart';

class DioClient {
  final Dio dio = Dio();

  Future<DioClient> init() async {
    final sessionService = locator<SessionService>();
    final String? token = sessionService.read(SessionKey.token);

    String savedBaseUrl = await ServerConfig.getBaseUrl();
    if (savedBaseUrl.isEmpty) {
      savedBaseUrl = "http://${ApiConfig.defaultBaseUrl}/";
    }

    dio.options = BaseOptions(
      baseUrl: savedBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      responseType: ResponseType.json,
    );

    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        request: true,
        responseBody: true,
        responseHeader: false,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );

    return this;
  }
}
