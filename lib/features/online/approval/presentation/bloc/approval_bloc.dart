import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'approval_event.dart';

class ApprovalScreenBloc
    extends Bloc<ApprovalScreenEvent, ApprovalScreenState> {
  final ApiDatafeedRepository repository;
  String? currentSearch;
  int? currentActionType;
  int? currentStatus;
  int currentPage = 1;
  int currentSize = 30;

  void applyFilters({String? search, int? actionType, int? status}) {
    currentSearch = search?.trim();
    currentActionType = actionType;
    currentStatus = status;
    currentPage = 1;
    add(const ApprovalScreenEvent.fetchApprovals());
  }

  ApprovalScreenBloc({required this.repository})
    : super(const ApprovalScreenState.initial()) {
    on<ApprovalScreenEvent>((event, emit) async {
      await event.map(
        fetchApprovals: (_) async => await _onFetchApprovals(emit),
        approveItem: (e) async => await _onApproveItem(e.data, emit),
        rejectItem: (e) async => await _onRejectItem(e.data, emit),
      );
    });
  }

  Future<void> _onFetchApprovals(Emitter<ApprovalScreenState> emit) async {
    emit(const ApprovalScreenState.loading());

    final result = await repository.fetchApprovals(
      search: currentSearch,
      actionType: currentActionType,
      status: currentStatus,
      page: currentPage,
      size: currentSize,
    );

    result.fold(
      (error) => emit(ApprovalScreenState.error(error)),
      (data) => emit(ApprovalScreenState.loaded(data)),
    );
  }

  Future<void> _onApproveItem(
    ApprovalScreenModel data,
    Emitter<ApprovalScreenState> emit,
  ) async {
    await _updateApproval(
      data,
      status: 2,
      actionName: 'menyetujui',
      emit: emit,
    );
  }

  Future<void> _onRejectItem(
    ApprovalScreenModel data,
    Emitter<ApprovalScreenState> emit,
  ) async {
    await _updateApproval(data, status: 0, actionName: 'menolak', emit: emit);
  }

  Future<void> _updateApproval(
    ApprovalScreenModel data, {
    required int status,
    required String actionName,
    required Emitter<ApprovalScreenState> emit,
  }) async {
    emit(const ApprovalScreenState.loading());
    final approvalId = int.tryParse(data.approvalId);
    if (approvalId == null) {
      emit(
        ApprovalScreenState.error(
          'Gagal $actionName: ApprovalId tidak valid (${data.approvalId})',
        ),
      );
      return;
    }

    var actionTypeId = 1;
    if (data.action.toLowerCase() == 'edit') {
      actionTypeId = 2;
    } else if (data.action.toLowerCase() == 'delete') {
      actionTypeId = 3;
    }

    final result = await repository.updateApprovalStatus({
      'ApprovalId': approvalId,
      'ApprovedBy': 'admin',
      'Email': data.email == '-' ? '' : data.email,
      'LoginId': data.loginId,
      'Status': status,
      'ActionType': actionTypeId,
    });

    await result.fold(
      (error) async {
        emit(ApprovalScreenState.error('Gagal $actionName: $error'));
      },
      (_) async {
        await _onFetchApprovals(emit);
      },
    );
  }
}
