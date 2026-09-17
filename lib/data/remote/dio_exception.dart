import 'dart:io' show SocketException;
import 'package:dio/dio.dart' show DioException, DioExceptionType;

import '../../core/constants/app_string.dart';

class DioExceptions implements Exception {
  const DioExceptions._({
    required this.message,
    this.statusCode,
    this.responseData,
  });

  factory DioExceptions.fromDioError(DioException dioException) {
    final message = switch (dioException.type) {
      DioExceptionType.cancel => AppString.cancelRequest,
      DioExceptionType.connectionTimeout => AppString.connectionTimeOut,
      DioExceptionType.receiveTimeout => AppString.receiveTimeOut,
      DioExceptionType.badResponse => _handleError(
        dioException.response?.statusCode,
        dioException.response?.data,
      ),
      DioExceptionType.sendTimeout => AppString.sendTimeOut,
      DioExceptionType.connectionError => AppString.connectionError,
      DioExceptionType.unknown =>
        dioException.error is SocketException
            ? AppString.socketException
            : '${AppString.unexpectedError}$dioException',
      _ => AppString.unknownError,
    };

    return DioExceptions._(
      message: message,
      statusCode: dioException.response?.statusCode,
      responseData: dioException.response?.data,
    );
  }

  final String message;
  final int? statusCode;
  final dynamic responseData;

  static String _handleError(int? statusCode, dynamic error) {
    String serverErrorMessage = '';
    if (error is Map) {
      final directMessage = error['message'];
      final metaMessage = error['meta'] is Map
          ? error['meta']['message']
          : null;
      final dataMessage = error['data'] is Map
          ? error['data']['message']
          : null;
      serverErrorMessage =
          (directMessage ?? metaMessage ?? dataMessage)?.toString().trim() ??
          '';
    }
    String statusMessage;
    switch (statusCode) {
      case 400:
        statusMessage = AppString.badRequest;
        break;
      case 401:
        statusMessage = AppString.unauthorized;
        break;
      case 403:
        statusMessage = AppString.forbidden;
        break;
      case 404:
        statusMessage = AppString.notFound;
        break;
      case 409:
        statusMessage = AppString.conflict;
        break;
      case 422:
        statusMessage = AppString.duplicateEmail;
        break;
      case 500:
        statusMessage = AppString.internalServerError;
        break;
      case 502:
        statusMessage = AppString.badGateway;
        break;
      default:
        statusMessage = AppString.unknownError;
        break;
    }
    return serverErrorMessage.isEmpty
        ? statusMessage
        : '$statusMessage - $serverErrorMessage';
  }

  @override
  String toString() => message;
}
