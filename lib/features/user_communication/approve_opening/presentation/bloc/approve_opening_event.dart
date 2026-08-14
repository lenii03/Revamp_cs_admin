import 'package:equatable/equatable.dart';
import '../../data/models/approve_opening_account_model.dart';

abstract class ApproveOpeningEvent extends Equatable {
  const ApproveOpeningEvent();
  @override
  List<Object> get props => [];
}

class AddToStaging extends ApproveOpeningEvent {
  final ApproveOpeningAccountModel account;
  const AddToStaging(this.account);
  @override
  List<Object> get props => [account];
}

class RemoveFromStaging extends ApproveOpeningEvent {
  final ApproveOpeningAccountModel account;
  const RemoveFromStaging(this.account);
  @override
  List<Object> get props => [account];
}

class ClearStaging extends ApproveOpeningEvent {}

class SelectStagedAccount extends ApproveOpeningEvent {
  final ApproveOpeningAccountModel account;
  const SelectStagedAccount(this.account);

  @override
  List<Object> get props => [account];
}

class SendEmailOpeningAccount extends ApproveOpeningEvent {
  final String loginId;
  final String custId;

  const SendEmailOpeningAccount({required this.loginId, required this.custId});

  @override
  List<Object> get props => [loginId, custId];
}

class SendEmailOpeningAccountToAll extends ApproveOpeningEvent {}
