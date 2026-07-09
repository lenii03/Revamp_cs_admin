import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:equatable/equatable.dart';

abstract class OnlineIdEvent extends Equatable {
  const OnlineIdEvent();

  @override
  List<Object?> get props => [];
}

class FetchOnlineIdsEvent extends OnlineIdEvent {}

class AddOnlineIdEvent extends OnlineIdEvent {
  final Map<String, dynamic> data;
  const AddOnlineIdEvent(this.data);
  @override
  List<Object> get props => [data];
}

class EditOnlineIdEvent extends OnlineIdEvent {
  final Map<String, dynamic> data;
  const EditOnlineIdEvent(this.data);
  @override
  List<Object> get props => [data];
}

class DeleteOnlineIdEvent extends OnlineIdEvent {
  final String loginId;
  const DeleteOnlineIdEvent(this.loginId);
  @override
  List<Object> get props => [loginId];
}

class ResetOnlineIdEvent extends OnlineIdEvent {
  final String loginId;
  final String resetType;
  const ResetOnlineIdEvent({required this.loginId, required this.resetType});
  @override
  List<Object> get props => [loginId, resetType];
}

class SelectOnlineIdEvent extends OnlineIdEvent {
  final OnlineIdModel selectedUser;
  const SelectOnlineIdEvent(this.selectedUser);
  
  @override
  List<Object> get props => [selectedUser];
}