import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import '../../domain/usecases/notification_usecases.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetSchedulersUseCase _getSchedulers;
  final CreateSchedulerUseCase _createScheduler;

  NotificationBloc({required GetSchedulersUseCase getSchedulers, required CreateSchedulerUseCase createScheduler}) : _getSchedulers = getSchedulers, _createScheduler = createScheduler, super(NotificationInitial()) {
    on<FetchSchedulers>((event, emit) async {
      emit(NotificationLoading());
      final result = await _getSchedulers();
      result.fold(
        (error) => emit(NotificationError(error)),
        (data) => emit(SchedulerLoaded(data)),
      );
    });

    on<CreateScheduler>((event, emit) async {
      emit(NotificationLoading());
      final result = await _createScheduler(
        event.payload,
      );
      result.fold(
        (error) => emit(NotificationError(error)),
        (message) => emit(NotificationActionSuccess(message)),
      );
      add(FetchSchedulers());
    });
  }
}
