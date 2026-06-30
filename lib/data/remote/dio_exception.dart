import 'dart:io' show SocketException;
import 'package:dio/dio.dart' show DioException, DioExceptionType;

import '../../core/constants/app_string.dart';

/*
handling error dio
 */
class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = AppString.cancelRequest;
        break;
      case DioExceptionType.connectionTimeout:
        message = AppString.connectionTimeOut;
        break;
      case DioExceptionType.receiveTimeout:
        message = AppString.receiveTimeOut;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = AppString.sendTimeOut;
        break;
      case DioExceptionType.connectionError:
        message = AppString.connectionError;
        break;
      case DioExceptionType.unknown:
        if (dioException.error is SocketException) {
          message = AppString.socketException;
          break;
        }
        message = "${AppString.unexpectedError}$dioException";
        break;
      default:
        message = AppString.unknownError;
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    String serverErrorMessage = '';
    if (error is Map<String, dynamic> && error.containsKey('message')) {
      serverErrorMessage = error['message'];
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
    if (serverErrorMessage.isNotEmpty) {
      return '$statusMessage - $serverErrorMessage';
    } else {
      return statusMessage;
    }
  }

  @override
  String toString() => message;
}
