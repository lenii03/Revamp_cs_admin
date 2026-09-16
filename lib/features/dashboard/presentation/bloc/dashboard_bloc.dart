import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_dashboard_metrics_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required GetDashboardMetricsUseCase getMetrics})
    : _getMetrics = getMetrics,
      super(DashboardInitial()) {
    on<FetchDashboardMetricsEvent>(_onFetchMetrics);
  }

  final GetDashboardMetricsUseCase _getMetrics;

  Future<void> _onFetchMetrics(
    FetchDashboardMetricsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final result = await _getMetrics();
    result.fold(
      (error) => emit(DashboardError(error)),
      (metrics) => emit(
        DashboardLoaded(
          totalCs: metrics.totalCs,
          totalUserOnline: metrics.totalUserOnline,
          totalPending: metrics.totalPending,
          incompleteCredentials: metrics.incompleteCredentials,
          incompleteCredentialUsers: metrics.incompleteCredentialUsers,
          errors: metrics.errors,
        ),
      ),
    );
  }
}
