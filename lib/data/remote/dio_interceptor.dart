import 'dart:async';

import 'package:dio/dio.dart';
import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/core/network/session_expired_handler.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sessionService = locator<SessionService>();
    final token = sessionService.read(SessionKey.token);
    final isAuthenticationRequest = _isAuthenticationRequest(options.path);

    if (isAuthenticationRequest) {
      options.headers.remove('Authorization');
    }

    options.headers.addAll({
      "Access-Control-Allow-Origin": "*",
      "Accept": "*/*",
      if (token.isNotEmpty && !isAuthenticationRequest)
        "Authorization": "Bearer $token",
    });
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 &&
        !_isAuthenticationRequest(err.requestOptions.path)) {
      unawaited(SessionExpiredHandler.handle());
    }
    handler.next(err);
  }

  bool _isAuthenticationRequest(String path) {
    final normalizedPath = path.toLowerCase().replaceFirst(RegExp(r'^/+'), '');
    return normalizedPath.endsWith(Endpoint.signIn.toLowerCase()) ||
        normalizedPath.endsWith(Endpoint.signOut.toLowerCase()) ||
        normalizedPath.endsWith(Endpoint.resetPasswordCs.toLowerCase());
  }
}
