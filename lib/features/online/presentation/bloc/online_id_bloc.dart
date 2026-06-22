import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'online_id_event.dart';
import 'online_id_state.dart';

class OnlineIdBloc extends Bloc<OnlineIdEvent, OnlineIdState> {
  final ApiDatafeedRepository repository;

  OnlineIdBloc({required this.repository}) : super(OnlineIdInitial()) {
    on<FetchOnlineIdsEvent>((event, emit) async {
      emit(OnlineIdLoading());
      
      final result = await repository.fetchOnlineIds(); // Nanti kita daftarkan ini di repo
      
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (data) => emit(OnlineIdLoaded(data)),
      );
    });
  }
}