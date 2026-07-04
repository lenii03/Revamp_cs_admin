import 'package:el_csadmin/shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cs_logs_event.dart';
import 'cs_logs_state.dart';

class CsLogsBloc extends Bloc<CsLogsEvent, CsLogsState> {
  final ApiDatafeedRepository repository;
  int currentPage = 1;
  int perPage = 30;
  String currentLoginId = '';
  String currentTargetId = '';
  int currentLogType = -1;

  CsLogsBloc({required this.repository}) : super(CsLogsInitial()) {
    on<FetchCsLogsEvent>((event, emit) async {
      emit(CsLogsLoading());

      if (event.page != null) currentPage = event.page!;
      if (event.perPage != null) perPage = event.perPage!;
      if (event.loginId != null) currentLoginId = event.loginId!;
      if (event.targetId != null) currentTargetId = event.targetId!;
      if (event.logType != null) currentLogType = event.logType!;

      final result = await repository.fetchCsLogs(
        loginId: currentLoginId,
        targetId: currentTargetId,
        logType: currentLogType,
        page: currentPage,
        size: perPage,
      );

      result.fold(
        (error) => emit(CsLogsError(error)),
        (data) => emit(CsLogsLoaded(data)),
      );
    });
  }
}
