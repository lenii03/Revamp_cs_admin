import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_reset_pin_event.dart';
part 'report_reset_pin_state.dart';

class ReportResetPinBloc extends Bloc<ReportResetPinEvent, ReportResetPinState> {
  ReportResetPinBloc() : super(ReportResetPinInitial()) {
    on<ReportResetPinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
