import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../injector.dart';
import '../local/session_service.dart';
import '../../core/constants/api_config.dart';
import '../../core/network/server_config.dart';
import 'dio_exception.dart';
import 'dio_interceptor.dart';

class DioClient {
  DioClient() : _dio = Dio(), _usesSavedBaseUrl = true;

  DioClient.local({
    required String baseUrl,
    Map<String, dynamic>? headers,
    ResponseType responseType = ResponseType.json,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: const Duration(seconds: 15),
           receiveTimeout: const Duration(seconds: 15),
           headers: headers,
           responseType: responseType,
         ),
       ),
       _usesSavedBaseUrl = false;

  final Dio _dio;
  final bool _usesSavedBaseUrl;

  Future<DioClient> init() async {
    final sessionService = locator<SessionService>();
    final String token = sessionService.read(SessionKey.token);

    String savedBaseUrl = await ServerConfig.getBaseUrl();
    if (savedBaseUrl.isEmpty) {
      savedBaseUrl = "http://${ApiConfig.defaultBaseUrl}/";
    }

    _dio.options = BaseOptions(
      baseUrl: savedBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      responseType: ResponseType.json,
    );

    _dio.interceptors.clear();
    _dio.interceptors.add(DioInterceptor());
    _dio.interceptors.add(
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

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _request(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _request(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _request(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  void setBaseUrl(String baseUrl) {
    if (baseUrl.isNotEmpty) {
      _dio.options.baseUrl = baseUrl;
    }
  }

  Future<Response<T>> _request<T>(
    Future<Response<T>> Function() request,
  ) async {
    try {
      await _refreshBaseUrl();
      return await request();
    } on DioException catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }

  Future<void> _refreshBaseUrl() async {
    if (!_usesSavedBaseUrl) return;

    final savedBaseUrl = await ServerConfig.getBaseUrl();
    if (savedBaseUrl.isNotEmpty) {
      _dio.options.baseUrl = savedBaseUrl;
    }
  }
}
