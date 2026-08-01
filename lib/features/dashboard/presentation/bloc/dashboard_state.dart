abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final String totalCs;
  final String totalUserOnline;
  final String totalPending;

  DashboardLoaded({
    required this.totalCs,
    required this.totalUserOnline,
    required this.totalPending,
  });
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
