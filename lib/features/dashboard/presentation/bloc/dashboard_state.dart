import '../../data/models/incomplete_credential_item.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final String totalCs;
  final String totalUserOnline;
  final String totalPending;
  final String incompleteCredentials;
  final List<IncompleteCredentialItem> incompleteCredentialUsers;
  final Map<String, String> errors;

  DashboardLoaded({
    required this.totalCs,
    required this.totalUserOnline,
    required this.totalPending,
    required this.incompleteCredentials,
    required this.incompleteCredentialUsers,
    this.errors = const {},
  });
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
