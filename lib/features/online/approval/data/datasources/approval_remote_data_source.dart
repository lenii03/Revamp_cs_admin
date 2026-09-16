import 'package:dio/dio.dart';
import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/core/network/server_config.dart';
import '../models/link_account_model.dart';
import '../models/approval_screen_model.dart';

abstract class ApprovalRemoteDataSource {
  Future<List<ApprovalScreenModel>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    required int page,
    required int size,
  });
  Future<void> updateApprovalStatus(Map<String, dynamic> payload);
  Future<Map<String, dynamic>> fetchLinkedAccountsDetail({
    required String loginId,
    required String approvalId,
  });
}

class ApprovalRemoteDataSourceImpl implements ApprovalRemoteDataSource {
  const ApprovalRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  Future<void> _configureBaseUrl() async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('Server IP is not configured.');
    _dio.options.baseUrl = baseUrl;
  }

  @override
  Future<List<ApprovalScreenModel>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    required int page,
    required int size,
  }) async {
    await _configureBaseUrl();
    final query = <String, dynamic>{'page': page, 'size': size};
    if (actionType != null) query['actionType'] = actionType;
    if (status != null) query['status'] = status;
    final normalizedSearch = search?.trim() ?? '';
    if (normalizedSearch.isNotEmpty) {
      final parts = normalizedSearch.split(' - ');
      query['loginId'] = parts.first.trim();
      if (parts.length > 1) {
        query['createdBy'] = parts.skip(1).join(' - ').trim();
      }
    }
    final response = await _dio.get(
      Endpoint.getApprovalList,
      queryParameters: query,
    );
    final data = response.data is Map ? response.data['data'] : null;
    return (data is List ? data : const <dynamic>[])
        .map(
          (item) => ApprovalScreenModel.fromMap(item as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> updateApprovalStatus(Map<String, dynamic> payload) async {
    await _configureBaseUrl();
    final response = await _dio.post(
      Endpoint.updateStatusApprovalUser,
      data: payload,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.data['message'] ?? 'Failed to process approval');
    }
  }

  @override
  Future<Map<String, dynamic>> fetchLinkedAccountsDetail({
    required String loginId,
    required String approvalId,
  }) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    _dio.options.baseUrl = baseUrl;

    List<LinkAccountInfoModel> oldLinks = [];
    List<NewLinkAccountInfoModel> newLinks = [];
    try {
      final response = await _dio.get(
        Endpoint.getLinkedInfoAccount,
        queryParameters: {'loginId': loginId},
      );
      final data = response.data is Map ? response.data['data'] : null;
      oldLinks = (data is List ? data : const <dynamic>[])
          .map((item) => LinkAccountInfoModel.fromMap(item))
          .toList();
    } catch (_) {
    }

    try {
      final response = await _dio.get(
        Endpoint.getLinkedInfoAccountApproval,
        queryParameters: {'approvalId': approvalId},
      );
      final responseData = response.data;
      final data = responseData is Map
          ? responseData['data'] ?? responseData['List']
          : null;
      newLinks = (data is List ? data : const <dynamic>[])
          .map((item) => NewLinkAccountInfoModel.fromMap(item))
          .toList();
    } catch (_) {
    }

    return {'old': oldLinks, 'new': newLinks};
  }
}
