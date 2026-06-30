import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_send_pwd_pin_event.dart';
part 'report_send_pwd_pin_state.dart';

class ReportSendPwdPinBloc extends Bloc<ReportSendPwdPinEvent, ReportSendPwdPinState> {
  ReportSendPwdPinBloc() : super(ReportSendPwdPinInitial()) {
    on<ReportSendPwdPinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
