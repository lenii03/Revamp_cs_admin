import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/approve_opening_account_model.dart';

part 'approve_opening_state.freezed.dart';

@freezed
abstract class ApproveOpeningState with _$ApproveOpeningState {
  const factory ApproveOpeningState.initial() = ApproveOpeningInitial;

  const factory ApproveOpeningState.loading() = ApproveOpeningLoading;

  const factory ApproveOpeningState.loaded(
    List<ApproveOpeningAccountModel> data, {
    ApproveOpeningAccountModel? selectedAccount,
    @Default(false) bool isSending,
    String? notification,
    @Default(false) bool notificationIsError, 
  }) = ApproveOpeningLoaded;

  const factory ApproveOpeningState.error(String message) = ApproveOpeningError;
}
   