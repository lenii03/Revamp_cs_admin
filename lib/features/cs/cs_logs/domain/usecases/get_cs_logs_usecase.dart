import 'package:dartz/dartz.dart';
import '../entities/cs_log.dart';
import '../repositories/cs_logs_repository.dart';

class GetCsLogsUseCase {
  const GetCsLogsUseCase(this._repository);
  final CsLogsRepository _repository;

  Future<Either<String, List<CsLog>>> call({
    String? loginId,
    String? targetId,
    int? logType,
    required int page,
    required int pageSize,
  }) async {
    final result = await _repository.fetchLogs(
      loginId: loginId,
      targetId: targetId,
      logType: logType,
      page: page,
      pageSize: pageSize,
    );

    // The legacy CS Admin applies this safeguard after loading the API
    // response. Keep it in the use case so a server response that ignores a
    // logType query can never make unrelated rows appear in the table.
    if (logType == null || logType < 0) return result;

    return result.map(
      (logs) => logs
          .where((log) => int.tryParse(log.logType) == logType)
          .toList(growable: false),
    );
  }
}
