import '../../domain/entities/dashboard_metrics.dart';
import 'incomplete_credential_item.dart';

class DashboardMetricsModel {
  const DashboardMetricsModel({
    required this.totalCs,
    required this.totalUserOnline,
    required this.totalPending,
    required this.incompleteCredentials,
    required this.incompleteCredentialUsers,
    required this.errors,
  });

  final String totalCs;
  final String totalUserOnline;
  final String totalPending;
  final String incompleteCredentials;
  final List<IncompleteCredentialItem> incompleteCredentialUsers;
  final Map<String, String> errors;

  DashboardMetrics toEntity() => DashboardMetrics(
    totalCs: totalCs,
    totalUserOnline: totalUserOnline,
    totalPending: totalPending,
    incompleteCredentials: incompleteCredentials,
    incompleteCredentialUsers: incompleteCredentialUsers
        .map((user) => user.toEntity())
        .toList(),
    errors: errors,
  );
}
