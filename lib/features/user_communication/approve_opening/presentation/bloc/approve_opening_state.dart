import 'package:equatable/equatable.dart';
import '../../data/models/approve_opening_account_model.dart';

abstract class ApproveOpeningState extends Equatable {
  const ApproveOpeningState();
  @override
  List<Object?> get props => [];
}

class ApproveOpeningInitial extends ApproveOpeningState {}

class ApproveOpeningLoading extends ApproveOpeningState {}

class ApproveOpeningLoaded extends ApproveOpeningState {
  final List<ApproveOpeningAccountModel> data;
  final ApproveOpeningAccountModel? selectedAccount;
  final bool isSending;
  final String? notification;
  final bool notificationIsError;

  const ApproveOpeningLoaded(
    this.data, {
    this.selectedAccount,
    this.isSending = false,
    this.notification,
    this.notificationIsError = false,
  });

  @override
  List<Object?> get props => [
    data,
    selectedAccount,
    isSending,
    notification,
    notificationIsError,
  ];
}

class ApproveOpeningError extends ApproveOpeningState {
  final String message;
  const ApproveOpeningError(this.message);
  @override
  List<Object> get props => [message];
}
