import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'approve_opening_event.dart';
import 'approve_opening_state.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import '../../data/models/approve_opening_account_model.dart';

class ApproveOpeningBloc
    extends Bloc<ApproveOpeningEvent, ApproveOpeningState> {
  final ApiDatafeedRepository repository;
  final List<ApproveOpeningAccountModel> _stagedAccounts = [];
  ApproveOpeningAccountModel? _selectedAccount;

  ApproveOpeningAccountModel? get selectedAccount => _selectedAccount;
  bool isStaged(ApproveOpeningAccountModel account) => _stagedAccounts.any(
    (item) => item.loginId == account.loginId && item.custId == account.custId,
  );

  bool get isSending =>
      state is ApproveOpeningLoaded &&
      (state as ApproveOpeningLoaded).isSending;

  List<ApproveOpeningAccountModel> apiAccountsList = [];

  ApproveOpeningBloc({required this.repository})
    : super(const ApproveOpeningLoaded([])) {
    _loadApiDataInBackground();

    on<AddToStaging>((event, emit) {
      if (!_stagedAccounts.any(
        (acc) =>
            acc.loginId == event.account.loginId &&
            acc.custId == event.account.custId,
      )) {
        _stagedAccounts.add(event.account);
      }
      _emitLoaded(emit);
    });

    on<RemoveFromStaging>((event, emit) {
      _stagedAccounts.removeWhere(
        (acc) =>
            acc.loginId == event.account.loginId &&
            acc.custId == event.account.custId,
      );
      if (_selectedAccount == event.account) _selectedAccount = null;
      _emitLoaded(emit);
    });

    on<ClearStaging>((event, emit) {
      _stagedAccounts.clear();
      _selectedAccount = null;
      emit(const ApproveOpeningLoaded([]));
    });

    on<SelectStagedAccount>((event, emit) {
      _selectedAccount = event.account;
    });

    on<SendEmailOpeningAccount>((event, emit) async {
      final account = _stagedAccounts
          .cast<ApproveOpeningAccountModel?>()
          .firstWhere(
            (item) =>
                item!.loginId == event.loginId && item.custId == event.custId,
            orElse: () => null,
          );
      if (account == null) return;

      _emitLoaded(emit, isSending: true);
      final result = await _send(account);
      result.fold(
        (error) => _emitLoaded(
          emit,
          notification: 'Failed to send email: $error',
          notificationIsError: true,
        ),
        (_) {
          _stagedAccounts.remove(account);
          if (_selectedAccount == account) {
            _selectedAccount = null;
          }

          _emitLoaded(emit, notification: 'Email sent successfully');
        },
      );
    });

    on<SendEmailOpeningAccountToAll>((event, emit) async {
      if (_stagedAccounts.isEmpty) return;
      _emitLoaded(emit, isSending: true);

      final accounts = _stagedAccounts.take(10).toList();
      final sent = <ApproveOpeningAccountModel>[];
      final errors = <String>[];
      for (final account in accounts) {
        final result = await _send(account);
        result.fold(errors.add, (_) => sent.add(account));
      }
      _stagedAccounts.removeWhere(sent.contains);
      _selectedAccount = null;
      _emitLoaded(
        emit,
        notification: errors.isEmpty
            ? '${sent.length} emails sent successfully'
            : '${sent.length} succeeded, ${errors.length} failed',
        notificationIsError: errors.isNotEmpty,
      );
    });
  }

  Future<Either<String, void>> _send(ApproveOpeningAccountModel account) {
    final csLoginId = locator<SessionService>().read(SessionKey.loginId);
    return repository.sendEmailOpeningAccount({
      'LoginId': account.loginId,
      'CustId': account.custId,
      'CSLoginId': csLoginId,
    });
  }

  void _emitLoaded(
    Emitter<ApproveOpeningState> emit, {
    bool isSending = false,
    String? notification,
    bool notificationIsError = false,
  }) {
    emit(
      ApproveOpeningLoaded(
        List.from(_stagedAccounts),
        selectedAccount: _selectedAccount,
        isSending: isSending,
        notification: notification,
        notificationIsError: notificationIsError,
      ),
    );
  }

  Future<void> _loadApiDataInBackground() async {
    final result = await repository.fetchOpeningAccounts(size: 30);
    result.fold(
      (error) => debugPrint("Failed to pre-fetch data: $error"),
      (data) => apiAccountsList = data,
    );
  }
}
