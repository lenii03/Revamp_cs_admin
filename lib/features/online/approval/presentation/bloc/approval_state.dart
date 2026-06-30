import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'approval_bloc.dart';
import 'approval_event.dart';

class ApprovalScreenBloc
    extends Bloc<ApprovalScreenEvent, ApprovalScreenState> {
  final ApiDatafeedRepository repository;

  ApprovalScreenBloc({required this.repository})
    : super(ApprovalScreenInitial()) {
    on<FetchApprovalsEvent>((event, emit) async {
      emit(ApprovalScreenLoading());

      final result = await repository.fetchApprovals();

      result.fold(
        (error) => emit(ApprovalScreenError(error)),
        (data) => emit(ApprovalScreenLoaded(data)),
      );
    });
  }
}
