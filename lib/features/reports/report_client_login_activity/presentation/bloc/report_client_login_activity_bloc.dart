import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_client_login_activity_event.dart';
part 'report_client_login_activity_state.dart';

class ReportClientLoginActivityBloc extends Bloc<ReportClientLoginActivityEvent, ReportClientLoginActivityState> {
  ReportClientLoginActivityBloc() : super(ReportClientLoginActivityInitial()) {
    on<ReportClientLoginActivityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
