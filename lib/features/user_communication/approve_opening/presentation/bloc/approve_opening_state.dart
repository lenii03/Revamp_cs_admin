import 'package:equatable/equatable.dart';
import '../../data/models/approve_opening_account_model.dart';

abstract class ApproveOpeningState extends Equatable {
  const ApproveOpeningState();
  @override
  List<Object> get props => [];
}

class ApproveOpeningInitial extends ApproveOpeningState {}
class ApproveOpeningLoading extends ApproveOpeningState {}
class ApproveOpeningLoaded extends ApproveOpeningState {
  final List<ApproveOpeningAccountModel> data;
  const ApproveOpeningLoaded(this.data);
  @override
  List<Object> get props => [data];
}
class ApproveOpeningError extends ApproveOpeningState {
  final String message;
  const ApproveOpeningError(this.message);
  @override
  List<Object> get props => [message];
}