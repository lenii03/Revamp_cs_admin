import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/notification_model.dart';

part 'notification_state.freezed.dart';

@freezed
abstract class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;

  const factory NotificationState.loading() = NotificationLoading;

  const factory NotificationState.schedulerLoaded(
    List<NotificationModel> data,
  ) = SchedulerLoaded;

  const factory NotificationState.actionSuccess(String message) =
      NotificationActionSuccess;

  const factory NotificationState.error(String message) = NotificationError;
}
