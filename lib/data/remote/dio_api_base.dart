import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show Response, DioException;
import 'package:flutter/material.dart';

import '../../features/cs/manage_cs/data/models/cs_user_model.dart';
import '../../injector.dart';
import '../local/session_service.dart';
import '../repositories/login_repository.dart';
import 'dio_exception.dart';

class DioApiBase<T> {
  String _extractErrorMessage(dynamic respons, String fallbackMessage) {
    if (respons != null) {
      if (respons is Map<String, dynamic>) {
        return respons["message"] ?? fallbackMessage;
      } else if (respons is String) {
        return 'Terjadi gangguan pada server. Silakan coba beberapa saat lagi.';
      }
    }
    return fallbackMessage;
  }

  Future<Either<String, LoginUserModel>> makeLoginRequest({
    required Future<Response<dynamic>> apiRequest,
    required Future<T> Function(Map<String, dynamic> rawData) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      T dataList = await decoder(json.decode(response.data));
      return right((dataList as LoginUserModel));
    } on DioException catch (e) {
      String errorMessage = DioExceptions.fromDioError(e).toString();
      final errorCode = e.response?.statusCode ?? 0;
      if (errorCode >= 400 && errorCode < 500 && errorCode != 404) {
        String rawResponse = e.response?.data.toString() ?? '';
        errorMessage = rawResponse;
        if (rawResponse.contains('"')) {
          errorMessage = rawResponse.replaceAll('"', '');
        }
      }
      return left(errorMessage);
    }
  }

  //! C
  Future<Either<String, LoginUserModel>> makeLoginRequestC({
    required Future<Response<dynamic>> apiRequest,
    required Future<T> Function(Map<String, dynamic> rawData) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      final loginUser = await decoder(response.data);

      return right(loginUser as LoginUserModel);
    } on DioException catch (e) {
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  Future<Either<String, String>> makeSingleRequest({
    required Future<Response<dynamic>> apiRequest,
  }) async {
    try {
      final Response response = await apiRequest;
      var rawResponse = response.data;

      String success = 'success';
      if (rawResponse is Map) {
        success = rawResponse["message"] ?? 'success';
      }
      return right(success);
    } on DioException catch (e) {
      print("ini print $e");
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);
      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  Future<Either<String, String>> makeSingleRequestUnique({
    required Future<Response<dynamic>> apiRequest,
  }) async {
    try {
      final Response response = await apiRequest;
      String success = 'success';
      return right(success);
    } on DioException catch (e) {
      print("ini print $e");
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  //!java
  Future<Either<String, T>> makeSingleRequestModel({
    required Future<Response<dynamic>> apiRequest,
    required Future<T> Function(Map<String, dynamic> rawData) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      final T result;
      if (response.data is Map) {
        result = await decoder(response.data);
      } else {
        result = await decoder(jsonDecode(response.data));
      }
      return right(result);
    } on DioException catch (e) {
      print("ini print $e");
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = fallback;

      if (e.response?.statusCode == 409) {
        if (e.response?.data is String) {
          var rawResponse = jsonDecode(e.response!.data);
          errorMessage = rawResponse?["message"] ?? 'Conflict, data exist';
        }
      }
      return left(errorMessage);
    }
  }

  //! C
  Future<Either<String, T>> makeSingleRequestModelC({
    required Future<Response<dynamic>> apiRequest,
    required Future<T> Function(Map<String, dynamic> rawData) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      if (response.data is Map<String, dynamic>) {
        final finalData = await decoder(response.data as Map<String, dynamic>);
        return right(finalData);
      } else {
        return left('Unexpected response format');
      }
    } on DioException catch (e) {
      print("ini print $e");
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }

      return left(errorMessage);
    }
  }

  Future<Either<String, T>> makeRequest({
    required Future<Response<dynamic>> apiRequest,
    required T emptyObject,
  }) async {
    try {
      final Response response = await apiRequest;
      if (response.statusCode == 200) {}
      return right(emptyObject);
    } on DioException catch (e) {
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  //!java
  Future<Either<String, List<T>>> makeRequestList({
    required Future<Response<dynamic>> apiRequest,
    required Future<List<T>> Function(Map<String, dynamic> rawData) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      final List<T> dataList = await decoder(json.decode(response.data));
      return right(dataList);
    } on DioException catch (e) {
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);
      return left(errorMessage);
    }
  }

  //!c
  Future<Either<String, List<T>>> makeRequestListC({
    required Future<Response<dynamic>> apiRequest,
    required Future<List<T>> Function(Map<String, dynamic> rawData) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      final List<T> dataList = await decoder(response.data);
      return right(dataList);
    } on DioException catch (e) {
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  //!C binnary
  Future<Either<String, List<T>>> makeRequestListCBinnary({
    required Future<Response<dynamic>> apiRequest,
    required Future<List<T>> Function(Response<dynamic> response) decoder,
  }) async {
    try {
      final Response response = await apiRequest;
      final List<T> dataList = await decoder(response);
      return right(dataList);
    } on DioException catch (e) {
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  // Future<Either<String, LinkAccountModel>> makeRequestLinkAccount({
  //   required Future<Response<dynamic>> apiRequest,
  //   required Future<LinkAccountModel> Function(Map<String, dynamic> rawData)
  //   decoder,
  // }) async {
  //   try {
  //     final Response response = await apiRequest;
  //     final LinkAccountModel data = await decoder(json.decode(response.data));
  //     return right(data);
  //   } on DioException catch (e) {
  //     String fallback = DioExceptions.fromDioError(e).toString();
  //     String errorMessage = _extractErrorMessage(e.response?.data, fallback);

  //     if (e.response?.statusCode == 401) {
  //       _handleUnauthorized();
  //     }
  //     return left(errorMessage);
  //   }
  // }

  Future<Either<String, ManageCsUsersModel>> makeAddCs({
    required Future<Response<dynamic>> apiRequest,
  }) async {
    try {
      final Response response = await apiRequest;
      if (response.statusCode == 200) {}
      return right(
        ManageCsUsersModel(
          loginId: '',
          employeeId: '',
          email: '',
          isActive: false,
          isCs: false,
          isOnline: false,
          permissions: 0,
          created: '-',
          lastModified: '-',
          lastLogin: '-',
          createdBy: '-',
          modifiedBy: '-',
        ),
      );
    } on DioException catch (e) {
      String fallback = DioExceptions.fromDioError(e).toString();
      String errorMessage = _extractErrorMessage(e.response?.data, fallback);

      if (e.response?.statusCode == 401) {
        _handleUnauthorized();
      }
      return left(errorMessage);
    }
  }

  void _handleUnauthorized() {
    final sessionService = locator<SessionService>();
    sessionService.remove(SessionKey.token);
  }
}
