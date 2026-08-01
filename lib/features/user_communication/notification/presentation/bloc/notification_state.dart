import 'package:equatable/equatable.dart';
import '../../data/models/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class SchedulerLoaded extends NotificationState {
  final List<NotificationModel> data;
  const SchedulerLoaded(this.data);
  @override
  List<Object> get props => [data];
}
class NotificationActionSuccess extends NotificationState {
  final String message;
  const NotificationActionSuccess(this.message);
  @override
  List<Object> get props => [message];
}
class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
  @override
  List<Object> get props => [message];
}