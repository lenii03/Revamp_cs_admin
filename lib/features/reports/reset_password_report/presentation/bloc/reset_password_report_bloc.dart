import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_password_report_event.dart';
part 'reset_password_report_state.dart';

class ResetPasswordReportBloc extends Bloc<ResetPasswordReportEvent, ResetPasswordReportState> {
  ResetPasswordReportBloc() : super(ResetPasswordReportInitial()) {
    on<ResetPasswordReportEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
