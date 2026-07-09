import 'package:equatable/equatable.dart';
import '../../data/models/send_email_forgot_model.dart';

abstract class SendEmailForgotEvent extends Equatable {
  const SendEmailForgotEvent();

  @override
  List<Object?> get props => [];
}

class FetchSendEmailData extends SendEmailForgotEvent {}

class SubmitSendEmail extends SendEmailForgotEvent {
  final SendEmailForgotModel data;
  final int index;

  const SubmitSendEmail({required this.data, required this.index});

  @override
  List<Object?> get props => [data, index];
}
