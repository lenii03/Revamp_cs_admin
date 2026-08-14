import 'package:equatable/equatable.dart';

abstract class SendEmailForgotEvent extends Equatable {
  const SendEmailForgotEvent();

  @override
  List<Object?> get props => [];
}

class FetchSendEmailData extends SendEmailForgotEvent {}
