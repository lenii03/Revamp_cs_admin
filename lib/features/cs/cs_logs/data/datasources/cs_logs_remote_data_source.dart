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
        // Keep the request contract identical to the legacy CS Admin.
        // The API may distinguish an omitted filter from an explicit
        // "Show All" value (-1) or an empty search field.
        'csLoginId': loginId ?? '',
        'loginId': targetId ?? '',
        'logType': logType ?? -1,
      },
    );
    final data = response.data is Map ? response.data['data'] : null;
    return (data is List ? data : const <dynamic>[])
        .whereType<Map>()
        .map((item) => CsLogModel.fromMap(Map<String, dynamic>.from(item)))
        .toList();
  }
}
