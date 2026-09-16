import 'package:dartz/dartz.dart';

import '../entities/dashboard_metrics.dart';

abstract class DashboardRepository {
  Future<Either<String, DashboardMetrics>> fetchMetrics();
}
