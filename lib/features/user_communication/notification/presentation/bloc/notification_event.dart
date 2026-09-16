import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.freezed.dart';

@freezed
abstract class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.fetchSchedulers() = FetchSchedulers;

  const factory NotificationEvent.sendPushNotif({
    required String title,
    required String subtitle,
  }) = SendPushNotif;

  const factory NotificationEvent.createScheduler(
    Map<String, dynamic> payload,
  ) = CreateScheduler;
}
