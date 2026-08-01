import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class FetchSchedulers extends NotificationEvent {}

class SendPushNotif extends NotificationEvent {
  final String title;
  final String subtitle;
  const SendPushNotif({required this.title, required this.subtitle});
  @override
  List<Object> get props => [title, subtitle];
}

class CreateScheduler extends NotificationEvent {
  final Map<String, dynamic> payload;
  const CreateScheduler(this.payload);
  @override
  List<Object> get props => [payload];
}