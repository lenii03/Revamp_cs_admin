import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/approve_opening_account_model.dart';

part 'approve_opening_event.freezed.dart';

@freezed
abstract class ApproveOpeningEvent with _$ApproveOpeningEvent {
  const factory ApproveOpeningEvent.addToStaging(
    ApproveOpeningAccountModel account,
  ) = AddToStaging;

  const factory ApproveOpeningEvent.removeFromStaging(
    ApproveOpeningAccountModel account,
  ) = RemoveFromStaging;

  const factory ApproveOpeningEvent.clearStaging() = ClearStaging;

  const factory ApproveOpeningEvent.selectStagedAccount(
    ApproveOpeningAccountModel account,
  ) = SelectStagedAccount;

  const factory ApproveOpeningEvent.sendEmailOpeningAccount({
    required String loginId,
    required String custId,
  }) = SendEmailOpeningAccount;

  const factory ApproveOpeningEvent.sendEmailOpeningAccountToAll() =
      SendEmailOpeningAccountToAll;
}
