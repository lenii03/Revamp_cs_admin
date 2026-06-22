import 'package:equatable/equatable.dart';
import '../../data/models/approval_screen_model.dart';

abstract class ApprovalScreenState extends Equatable {
  const ApprovalScreenState();
  
  @override
  List<Object> get props => [];
}

class ApprovalScreenInitial extends ApprovalScreenState {}

class ApprovalScreenLoading extends ApprovalScreenState {}

class ApprovalScreenLoaded extends ApprovalScreenState {
  final List<ApprovalScreenModel> data;

  const ApprovalScreenLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class ApprovalScreenError extends ApprovalScreenState {
  final String message;

  const ApprovalScreenError(this.message);

  @override
  List<Object> get props => [message];
}