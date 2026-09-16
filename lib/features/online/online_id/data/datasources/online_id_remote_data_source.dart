import 'package:dio/dio.dart';
import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/core/network/server_config.dart';
import '../models/account_link_model.dart';
import '../models/online_id_model.dart';

abstract class OnlineIdRemoteDataSource {
  Future<List<OnlineIdModel>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  });
  Future<String> saveOnlineId(Map<String, dynamic> payload);
  Future<List<AccountLinkModel>> fetchAccountLinks();
  Future<List<AccountLinkModel>> fetchLinkedAccounts(String loginId);
  Future<String> resetPasswordOrPin(Map<String, dynamic> payload);
}

class OnlineIdRemoteDataSourceImpl implements OnlineIdRemoteDataSource {
  const OnlineIdRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  Future<void> _configureBaseUrl() async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('Server IP is not configured.');
    _dio.options.baseUrl = baseUrl;
  }

  @override
  Future<List<OnlineIdModel>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  }) async {
    await _configureBaseUrl();
    final query = <String, dynamic>{'page': page ?? 1, 'size': size ?? 30};
    if (search != null && search.isNotEmpty) {
      final normalized = search.trim();
      final separatorIndex = normalized.indexOf(' - ');
      if (separatorIndex >= 0) {
        query['loginId'] = normalized.substring(0, separatorIndex).trim();
        query['email'] = normalized.substring(separatorIndex + 3).trim();
      } else if (normalized.contains('@')) {
        query['email'] = normalized;
      } else {
        query['loginId'] = normalized;
      }
    }
    final response = await _dio.get(Endpoint.getOnlineUser, queryParameters: query);
    final data = response.data is Map ? response.data['data'] : null;
    return (data is List ? data : const <dynamic>[])
        .map((item) => OnlineIdModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<String> saveOnlineId(Map<String, dynamic> payload) async {
    await _configureBaseUrl();
    final response = await _dio.post(Endpoint.postAddOnUser, data: payload);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['message'] ?? 'Data processed successfully';
    }
    throw Exception(response.data['message'] ?? 'Failed to process data');
  }

  @override
  Future<List<AccountLinkModel>> fetchAccountLinks() async {
    await _configureBaseUrl();
    final response = await _dio.get(Endpoint.getAccountLink);
    final rawData = response.data is Map ? response.data['data'] : null;
    if (rawData is! List) return const [];
    return rawData
        .whereType<Map>()
        .map((item) => AccountLinkModel.fromMap(Map<String, dynamic>.from(item)))
        .where((item) => item.custId.isNotEmpty)
        .toList();
  }

  @override
  Future<List<AccountLinkModel>> fetchLinkedAccounts(String loginId) async {
    await _configureBaseUrl();
    final response = await _dio.get(
      Endpoint.getLinkedInfoAccount,
      queryParameters: {'loginId': loginId},
    );
    final rawData = response.data is Map ? response.data['data'] : null;
    if (rawData is! List) return const [];
    return rawData
        .whereType<Map>()
        .map((item) => AccountLinkModel.fromMap(Map<String, dynamic>.from(item)))
        .where((item) => item.custId.isNotEmpty)
        .toList();
  }

  @override
  Future<String> resetPasswordOrPin(Map<String, dynamic> payload) async {
    await _configureBaseUrl();
    final response = await _dio.post(Endpoint.resetPWDOrPIN, data: payload);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      return data is Map
          ? data['message']?.toString() ?? 'Password/PIN reset successfully'
          : 'Password/PIN reset successfully';
    }
    final data = response.data;
    throw Exception(
      data is Map ? data['message'] ?? 'Failed to reset Password/PIN' : 'Failed to reset Password/PIN',
    );
  }
}
