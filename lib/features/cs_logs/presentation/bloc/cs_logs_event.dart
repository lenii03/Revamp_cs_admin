
import 'package:equatable/equatable.dart';

abstract class CsLogsEvent extends Equatable {
  const CsLogsEvent();
  @override
  List<Object> get props => [];
}

class FetchCsLogsEvent extends CsLogsEvent {
  final String? loginId;
  final String? targetId;
  
  const FetchCsLogsEvent({this.loginId, this.targetId});
  
  @override
  List<Object> get props => [loginId ?? '', targetId ?? ''];
}