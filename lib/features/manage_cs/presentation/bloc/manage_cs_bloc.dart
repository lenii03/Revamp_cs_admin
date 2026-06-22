import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'manage_cs_event.dart';
import 'manage_cs_state.dart';

class ManageCsBloc extends Bloc<ManageCsEvent, ManageCsState> {
  final ApiDatafeedRepository repository;

  ManageCsBloc({required this.repository}) : super(ManageCsInitial()) {
    on<FetchCsList>((event, emit) async {
      emit(ManageCsLoading());

      final result = await repository.fetchCsList();

      result.fold(
        (error) => emit(ManageCsError(error)),
        (data) => emit(ManageCsLoaded(data)),
      );
    });
  }
}