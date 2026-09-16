import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/cs_log.dart';
import '../../domain/repositories/cs_logs_repository.dart';
import '../datasources/cs_logs_remote_data_source.dart';

class CsLogsRepositoryImpl implements CsLogsRepository {
  const CsLogsRepositoryImpl(this._remoteDataSource);
  final CsLogsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<String, List<CsLog>>> fetchLogs({
    String? loginId,
    String? targetId,
    int? logType,
    required int page,
    required int pageSize,
  }) async {
    try {
      final logs = await _remoteDataSource.fetchLogs(
        loginId: loginId,
        targetId: targetId,
        logType: logType,
        page: page,
        pageSize: pageSize,
      );
      return Right(logs.map((log) => log.toEntity()).toList());
    } on DioException catch (error) {
      final data = error.response?.data;
      final message = data is Map ? data['message']?.toString() : null;
      return Left(message ?? error.message ?? 'A network error occurred.');
    } catch (error) {
      return Left(error.toString().replaceFirst('Exception: ', ''));
    }
  }
}
