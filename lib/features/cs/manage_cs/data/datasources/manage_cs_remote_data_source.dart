import 'package:dio/dio.dart';
import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/data/remote/dio_client.dart';
import '../models/cs_user_model.dart';

abstract class ManageCsRemoteDataSource {
  Future<List<ManageCsUsersModel>> fetchUsers({
    required int page,
    required int pageSize,
  });

  Future<void> addUser(Map<String, dynamic> payload);
  Future<void> editUser(Map<String, dynamic> payload);
  Future<void> deleteUser({required String loginId, required String deletedBy});
  Future<void> resetPassword(Map<String, dynamic> payload);
}

class ManageCsRemoteDataSourceImpl implements ManageCsRemoteDataSource {
  const ManageCsRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<List<ManageCsUsersModel>> fetchUsers({
    required int page,
    required int pageSize,
  }) async {
    final response = await _client.get(
      Endpoint.getCSList,
      queryParameters: const {'page': 1, 'size': 30},
    );
    final data = response.data is Map ? response.data['data'] : null;
    final users = data is List ? data : const <dynamic>[];
    return users
        .whereType<Map>()
        .map(
          (item) => ManageCsUsersModel.fromMap(Map<String, dynamic>.from(item)),
        )
        .toList();
  }

  @override
  Future<void> addUser(Map<String, dynamic> payload) async {
    final response = await _client.post(Endpoint.postAddCs, data: payload);
    _ensureSuccess(response, 'Failed to add CS user');
  }

  @override
  Future<void> editUser(Map<String, dynamic> payload) async {
    final response = await _client.put(Endpoint.putEditCs, data: payload);
    _ensureSuccess(response, 'Failed to update CS user');
  }

  @override
  Future<void> deleteUser({
    required String loginId,
    required String deletedBy,
  }) async {
    final response = await _client.delete(
      Endpoint.deleteCs,
      queryParameters: {'loginId': loginId, 'deletedBy': deletedBy},
    );
    _ensureSuccess(response, 'Failed to delete CS user');
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> payload) async {
    final response = await _client.put(Endpoint.putResetPw, data: payload);
    _ensureSuccess(response, 'Failed to reset CS user password');
  }

  void _ensureSuccess(Response<dynamic> response, String fallbackMessage) {
    if (response.statusCode == 200 || response.statusCode == 201) return;
    final data = response.data;
    final message = data is Map ? data['message']?.toString() : null;
    throw Exception(message ?? fallbackMessage);
  }
}
