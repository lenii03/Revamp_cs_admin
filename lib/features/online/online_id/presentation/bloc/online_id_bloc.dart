import 'package:el_csadmin/shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'online_id_event.dart';
import 'online_id_state.dart';

class OnlineIdBloc extends Bloc<OnlineIdEvent, OnlineIdState> {
  final ApiDatafeedRepository repository;
  int currentPage = 1;
  int perPage = 30;
  String currentSearch = '';

  OnlineIdBloc({required this.repository}) : super(OnlineIdInitial()) {
    on<FetchOnlineIdsEvent>((event, emit) async {
      emit(OnlineIdLoading());
      
      final result = await repository.fetchOnlineIds(
        search: currentSearch,
        page: currentPage,
        size: perPage,
      );
      
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (data) => emit(OnlineIdLoaded(data)),
      );
    });

    on<AddOnlineIdEvent>((event, emit) async {
      emit(OnlineIdLoading());
      final result = await repository.addCsUser(event.data); 
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (_) => add(FetchOnlineIdsEvent()), 
      );
    });

    on<EditOnlineIdEvent>((event, emit) async {
      emit(OnlineIdLoading());
      final result = await repository.editCsUser(event.data);
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (_) => add(FetchOnlineIdsEvent()), 
      );
    });

    on<DeleteOnlineIdEvent>((event, emit) async {
      emit(OnlineIdLoading());
      final result = await repository.deleteCsUser(event.loginId);
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (_) => add(FetchOnlineIdsEvent()), 
      );
    });

    on<ResetOnlineIdEvent>((event, emit) async {
      emit(OnlineIdLoading());
      final payload = {"loginId": event.loginId, "type": event.resetType};
      final result = await repository.resetPassword(payload);
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (_) => add(FetchOnlineIdsEvent()),
      );
    });
  }
}