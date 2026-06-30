import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_email_event.dart';
part 'send_email_state.dart';

class SendEmailBloc extends Bloc<SendEmailEvent, SendEmailState> {
  SendEmailBloc() : super(SendEmailInitial()) {
    on<SendEmailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
