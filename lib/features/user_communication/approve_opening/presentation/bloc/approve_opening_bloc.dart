import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'approve_opening_event.dart';
part 'approve_opening_state.dart';

class ApproveOpeningBloc extends Bloc<ApproveOpeningEvent, ApproveOpeningState> {
  ApproveOpeningBloc() : super(ApproveOpeningInitial()) {
    on<ApproveOpeningEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
