import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_linked_account_event.dart';
part 'report_linked_account_state.dart';

class ReportLinkedAccountBloc extends Bloc<ReportLinkedAccountEvent, ReportLinkedAccountState> {
  ReportLinkedAccountBloc() : super(ReportLinkedAccountInitial()) {
    on<ReportLinkedAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
