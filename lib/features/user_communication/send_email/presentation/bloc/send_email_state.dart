part of 'send_email_bloc.dart';

abstract class SendEmailState extends Equatable {
  const SendEmailState();  

  @override
  List<Object> get props => [];
}
class SendEmailInitial extends SendEmailState {}
