import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_demo_account_event.dart';
part 'send_demo_account_state.dart';

class SendDemoAccountBloc extends Bloc<SendDemoAccountEvent, SendDemoAccountState> {
  SendDemoAccountBloc() : super(SendDemoAccountInitial()) {
    on<SendDemoAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
