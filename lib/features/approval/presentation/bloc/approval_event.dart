import 'package:equatable/equatable.dart';

abstract class ApprovalScreenEvent extends Equatable {
  const ApprovalScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchApprovalsEvent extends ApprovalScreenEvent {}