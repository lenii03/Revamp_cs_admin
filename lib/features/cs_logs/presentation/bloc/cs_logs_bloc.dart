import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'cs_logs_event.dart';
import 'cs_logs_state.dart';

class CsLogsBloc extends Bloc<CsLogsEvent, CsLogsState> {
  final ApiDatafeedRepository repository;

  CsLogsBloc({required this.repository}) : super(CsLogsInitial()) {
    on<FetchCsLogsEvent>((event, emit) async {
      emit(CsLogsLoading());
      
      final result = await repository.fetchCsLogs(
        loginId: event.loginId,
        targetId: event.targetId
      );
      
      result.fold(
        (error) => emit(CsLogsError(error)),
        (data) => emit(CsLogsLoaded(data)),
      );
    });
  }
}