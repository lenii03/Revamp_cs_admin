import 'package:dio/dio.dart';

abstract class NotificationRemoteDataSource {
  Future<List<dynamic>> fetchSchedulers();
  Future<void> sendPush(Map<String, dynamic> payload);
  Future<void> createScheduler(Map<String, dynamic> payload);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl(this._dio);
  final Dio _dio;
  @override
  Future<List<dynamic>> fetchSchedulers() async {
    try {
      final response = await _dio.get(
        '/cs/get-list-scheduler-notification',
        queryParameters: const {'page': 1, 'size': 10},
      );
      if (response.statusCode == 200)
        return response.data['data'] as List<dynamic>;
      throw Exception(
        response.data['message'] ?? 'Failed to load scheduler data',
      );
    } catch (e) {
      throw Exception('A network error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPush(Map<String, dynamic> payload) async {
    final response = await _dio.post('/cs/push-notification', data: payload);
    if (response.statusCode != 200 && response.statusCode != 201)
      throw Exception(
        response.data['message'] ?? 'Failed to send push notification',
      );
  }

  @override
  Future<void> createScheduler(Map<String, dynamic> payload) async {
    final response = await _dio.post(
      '/cs/create-scheduler-notification',
      data: payload,
    );
    if (response.statusCode != 200 && response.statusCode != 201)
      throw Exception(response.data['message'] ?? 'Failed to create scheduler');
  }
}
