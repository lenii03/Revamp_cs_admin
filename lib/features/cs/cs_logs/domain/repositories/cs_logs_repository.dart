import 'package:dartz/dartz.dart';
import '../entities/cs_log.dart';

abstract class CsLogsRepository {
  Future<Either<String, List<CsLog>>> fetchLogs({
    String? loginId,
    String? targetId,
    int? logType,
    required int page,
    required int pageSize,
  });
}
