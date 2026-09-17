import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/data/remote/dio_client.dart';
import '../models/cs_log_model.dart';

abstract class CsLogsRemoteDataSource {
  Future<List<CsLogModel>> fetchLogs({
    String? loginId,
    String? targetId,
    int? logType,
    required int page,
    required int pageSize,
  });
}


class CsLogsRemoteDataSourceImpl implements CsLogsRemoteDataSource {
  const CsLogsRemoteDataSourceImpl(this._client);
  final DioClient _client;

  @override
  Future<List<CsLogModel>> fetchLogs({
    String? loginId,
    String? targetId,
    int? logType,
    required int page,
    required int pageSize,
  }) async {
    final response = await _client.get(
      Endpoint.getCsLogs,
      queryParameters: {
        'page': page,
        'size': pageSize,
        if (loginId != null && loginId.isNotEmpty) 'csLoginId': loginId,
        if (targetId != null && targetId.isNotEmpty) 'loginId': targetId,
        if (logType != null && logType >= 0) 'logType': logType,
      },
    );
    final data = response.data is Map ? response.data['data'] : null;
    return (data is List ? data : const <dynamic>[])
        .whereType<Map>()
        .map((item) => CsLogModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}
