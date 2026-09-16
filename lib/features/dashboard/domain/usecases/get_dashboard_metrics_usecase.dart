import 'package:dartz/dartz.dart';

import '../entities/dashboard_metrics.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardMetricsUseCase {
  const GetDashboardMetricsUseCase(this._repository);

  final DashboardRepository _repository;

  Future<Either<String, DashboardMetrics>> call() => _repository.fetchMetrics();
}
