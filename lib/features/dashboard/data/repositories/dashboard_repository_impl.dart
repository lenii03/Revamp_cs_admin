import 'package:dartz/dartz.dart';

import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._remoteDataSource);

  final DashboardRemoteDataSource _remoteDataSource;

  @override
  Future<Either<String, DashboardMetrics>> fetchMetrics() async {
    try {
      final metrics = await _remoteDataSource.fetchMetrics();
      return Right(metrics.toEntity());
    } catch (error) {
      return Left(error.toString().replaceFirst('Exception: ', ''));
    }
  }
}
