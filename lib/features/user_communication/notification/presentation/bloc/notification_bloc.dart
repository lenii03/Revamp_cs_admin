import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ApiDatafeedRepository repository;

  NotificationBloc({required this.repository}) : super(NotificationInitial()) {
    on<FetchSchedulers>((event, emit) async {
      emit(NotificationLoading());
      final result = await repository.fetchSchedulerNotifications();
      result.fold(
        (error) => emit(NotificationError(error)),
        (data) => emit(SchedulerLoaded(data)),
      );
    });

    on<SendPushNotif>((event, emit) async {
      emit(NotificationLoading());
      final payload = {"Title": event.title, "Subtitle": event.subtitle};
      final result = await repository.sendPushNotification(payload);
      result.fold(
        (error) => emit(NotificationError(error)),
        (message) => emit(NotificationActionSuccess(message)),
      );
      add(FetchSchedulers());
    });

    on<CreateScheduler>((event, emit) async {
      emit(NotificationLoading());
      final result = await repository.createSchedulerNotification(
        event.payload,
      );
      result.fold(
        (error) => emit(NotificationError(error)),
        (message) => emit(NotificationActionSuccess(message)),
      );
      add(FetchSchedulers()); // Fetch ulang tabel setelah berhasil tambah
    });
  }
}
