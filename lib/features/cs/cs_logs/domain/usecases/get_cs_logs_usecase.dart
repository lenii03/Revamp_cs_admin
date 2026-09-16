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
  }) =>
      _repository.fetchLogs(
        loginId: loginId,
        targetId: targetId,
        logType: logType,
        page: page,
        pageSize: pageSize,
      );
}
