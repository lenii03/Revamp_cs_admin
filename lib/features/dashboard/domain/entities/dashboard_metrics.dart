import 'incomplete_credential.dart';

class DashboardMetrics {
  const DashboardMetrics({
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
  final List<IncompleteCredential> incompleteCredentialUsers;
  final Map<String, String> errors;
}
