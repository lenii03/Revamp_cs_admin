import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_state.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/approval_usecases.dart';
import 'approval_event.dart';

class ApprovalScreenBloc
    extends Bloc<ApprovalScreenEvent, ApprovalScreenState> {
  final GetApprovalsUseCase _getApprovals;
  final UpdateApprovalStatusUseCase _updateApprovalStatus;
  final GetApprovalLinkedAccountsDetailUseCase _getLinkedAccountsDetail;
  final SessionService _sessionService;
  String? currentSearch;
  int? currentActionType;
  int? currentStatus;
  int currentPage = 1;
  int currentSize = 30;
  bool lastActionSucceeded = false;
  bool lastActionRefreshFailed = false;
  String? lastActionError;
  List<ApprovalScreenModel> _lastLoadedApprovals = const [];

  void applyFilters({String? search, int? actionType, int? status}) {
    currentSearch = search?.trim();
    currentActionType = actionType;
    currentStatus = status;
    currentPage = 1;
    add(const ApprovalScreenEvent.fetchApprovals());
  }

  ApprovalScreenBloc({
    required GetApprovalsUseCase getApprovals,
    required UpdateApprovalStatusUseCase updateApprovalStatus,
    required GetApprovalLinkedAccountsDetailUseCase getLinkedAccountsDetail,
    required SessionService sessionService,
  }) : _getApprovals = getApprovals,
       _updateApprovalStatus = updateApprovalStatus,
       _getLinkedAccountsDetail = getLinkedAccountsDetail,
       _sessionService = sessionService,
       super(const ApprovalScreenState.initial()) {
    on<ApprovalScreenEvent>((event, emit) async {
      await event.map(
        fetchApprovals: (_) async => await _onFetchApprovals(emit),
        approveItem: (e) async => await _onApproveItem(e.data, emit),
        rejectItem: (e) async => await _onRejectItem(e.data, emit),
      );
    });
  }

  Future<void> _onFetchApprovals(
    Emitter<ApprovalScreenState> emit, {
    bool preserveDataOnError = false,
  }) async {
    if (!preserveDataOnError) {
      emit(const ApprovalScreenState.loading());
    }

    final result = await _getApprovals(
      search: currentSearch,
      actionType: currentActionType,
      status: currentStatus,
      page: currentPage,
      size: currentSize,
    );

    result.fold(
      (error) {
        if (preserveDataOnError && _lastLoadedApprovals.isNotEmpty) {
          lastActionRefreshFailed = true;
          emit(ApprovalScreenState.loaded(_lastLoadedApprovals));
          return;
        }
        emit(ApprovalScreenState.error(error));
      },
      (data) {
        _lastLoadedApprovals = List.unmodifiable(data);
        emit(ApprovalScreenState.loaded(data));
      },
    );
  }

  Future<Map<String, dynamic>> getLinkedAccountsDetail(
    String loginId,
    String approvalId,
  ) async {
    final result = await _getLinkedAccountsDetail(
      loginId: loginId,
      approvalId: approvalId,
    );
    return result.fold(
      (_) => const <String, dynamic>{'old': [], 'new': []},
      (detail) => detail,
    );
  }

  Future<void> _onApproveItem(
    ApprovalScreenModel data,
    Emitter<ApprovalScreenState> emit,
  ) async {
    await _updateApproval(data, status: 2, actionName: 'approve', emit: emit);
  }

  Future<void> _onRejectItem(
    ApprovalScreenModel data,
    Emitter<ApprovalScreenState> emit,
  ) async {
    await _updateApproval(data, status: 0, actionName: 'reject', emit: emit);
  }

  Future<void> _updateApproval(
    ApprovalScreenModel data, {
    required int status,
    required String actionName,
    required Emitter<ApprovalScreenState> emit,
  }) async {
    lastActionSucceeded = false;
    lastActionRefreshFailed = false;
    lastActionError = null;
    final approvalId = int.tryParse(data.approvalId);
    if (approvalId == null) {
      _emitActionFailure(
        emit,
        'Failed to $actionName: invalid ApprovalId (${data.approvalId})',
      );
      return;
    }

    final approvedBy = _sessionService.read(SessionKey.loginId);
    if (approvedBy.isEmpty) {
      _emitActionFailure(
        emit,
        'Failed to $actionName: the active CS Login ID was not found. Please log in again.',
      );
      return;
    }

    var actionTypeId = 1;
    if (data.action.toLowerCase() == 'edit') {
      actionTypeId = 2;
    } else if (data.action.toLowerCase() == 'delete') {
      actionTypeId = 3;
    }

    final result = await _updateApprovalStatus({
      'ApprovalId': approvalId,
      'ApprovedBy': approvedBy,
      'Email': data.email == '-' ? '' : data.email,
      'LoginId': data.loginId,
      'Status': status,
      'ActionType': actionTypeId,
    });

    await result.fold(
      (error) async {
        _emitActionFailure(emit, 'Failed to $actionName: $error');
      },
      (_) async {
        lastActionSucceeded = true;
        await _onFetchApprovals(emit, preserveDataOnError: true);
      },
    );
  }

  void _emitActionFailure(
    Emitter<ApprovalScreenState> emit,
    String message,
  ) {
    lastActionError = message;
    if (_lastLoadedApprovals.isNotEmpty) {
      // Force an observable state transition. Emitting the same loaded list
      // directly is ignored by Bloc, which would suppress the action error
      // notification while the UI correctly keeps the existing list visible.
      emit(const ApprovalScreenState.loading());
      emit(ApprovalScreenState.loaded(_lastLoadedApprovals));
      return;
    }
    emit(ApprovalScreenState.error(message));
  }
}
