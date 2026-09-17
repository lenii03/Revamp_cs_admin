import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/data/remote/dio_client.dart';

abstract class NotificationRemoteDataSource {
  Future<List<dynamic>> fetchSchedulers();
  Future<void> sendPush(Map<String, dynamic> payload);
  Future<void> createScheduler(Map<String, dynamic> payload);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl(this._client);
  final DioClient _client;
  @override
  Future<List<dynamic>> fetchSchedulers() async {
    try {
      final response = await _client.get(
        Endpoint.getListScheulerNotification,
        queryParameters: const {'page': 1, 'size': 10},
      );
      if (response.statusCode == 200) {
        return response.data['data'] as List<dynamic>;
      }
      throw Exception(
        response.data['message'] ?? 'Failed to load scheduler data',
      );
    } catch (e) {
      throw Exception('A network error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPush(Map<String, dynamic> payload) async {
    final response = await _client.post(
      Endpoint.pushNotification,
      data: payload,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        response.data['message'] ?? 'Failed to send push notification',
      );
    }
  }

  @override
  Future<void> createScheduler(Map<String, dynamic> payload) async {
    final response = await _client.post(
      Endpoint.createSchedulerNotification,
      data: payload,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.data['message'] ?? 'Failed to create scheduler');
    }
  }
}
