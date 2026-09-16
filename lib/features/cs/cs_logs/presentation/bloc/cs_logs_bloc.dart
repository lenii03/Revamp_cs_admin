import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cs_logs_usecase.dart';
import 'cs_logs_event.dart';
import 'cs_logs_state.dart';

class CsLogsBloc extends Bloc<CsLogsEvent, CsLogsState> {
  CsLogsBloc({required GetCsLogsUseCase getLogs})
    : _getLogs = getLogs,
      super(const CsLogsState()) {
    on<FetchCsLogsEvent>(_onFetch);
    on<ChangeCsLogsPage>((event, emit) {
      if (event.page >= 1) add(_eventForCurrentFilters(page: event.page));
    });
    on<ChangeCsLogsPageSize>((event, emit) {
      add(_eventForCurrentFilters(page: 1, pageSize: event.pageSize));
    });
  }

  final GetCsLogsUseCase _getLogs;

  Future<void> _onFetch(
    FetchCsLogsEvent event,
    Emitter<CsLogsState> emit,
  ) async {
    emit(state.copyWith(status: CsLogsStatus.loading, errorMessage: ''));
    final result = await _getLogs(
      loginId: event.loginId,
      targetId: event.targetId,
      logType: event.logType,
      page: event.page,
      pageSize: event.pageSize,
    );
    result.fold(
      (error) => emit(state.copyWith(
        status: CsLogsStatus.failure,
        errorMessage: error,
      )),
      (logs) => emit(state.copyWith(
        status: CsLogsStatus.success,
        logs: logs,
        loginId: event.loginId ?? '',
        targetId: event.targetId ?? '',
        logType: event.logType ?? -1,
        page: event.page,
        pageSize: event.pageSize,
      )),
    );
  }

  FetchCsLogsEvent _eventForCurrentFilters({int? page, int? pageSize}) =>
      FetchCsLogsEvent(
        loginId: state.loginId,
        targetId: state.targetId,
        logType: state.logType,
        page: page ?? state.page,
        pageSize: pageSize ?? state.pageSize,
      );
}
