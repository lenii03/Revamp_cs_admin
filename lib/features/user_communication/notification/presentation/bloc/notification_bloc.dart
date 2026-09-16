import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import '../../domain/usecases/notification_usecases.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetSchedulersUseCase _getSchedulers;
  final SendPushNotificationUseCase _sendPush;
  final CreateSchedulerUseCase _createScheduler;

  NotificationBloc({required GetSchedulersUseCase getSchedulers, required SendPushNotificationUseCase sendPush, required CreateSchedulerUseCase createScheduler}) : _getSchedulers = getSchedulers, _sendPush = sendPush, _createScheduler = createScheduler, super(NotificationInitial()) {
    on<FetchSchedulers>((event, emit) async {
      emit(NotificationLoading());
      final result = await _getSchedulers();
      result.fold(
        (error) => emit(NotificationError(error)),
        (data) => emit(SchedulerLoaded(data)),
      );
    });

    on<SendPushNotif>((event, emit) async {
      emit(NotificationLoading());
      final payload = {"Title": event.title, "Subtitle": event.subtitle};
      final result = await _sendPush(payload);
      result.fold(
        (error) => emit(NotificationError(error)),
        (message) => emit(NotificationActionSuccess(message)),
      );
      add(FetchSchedulers());
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
