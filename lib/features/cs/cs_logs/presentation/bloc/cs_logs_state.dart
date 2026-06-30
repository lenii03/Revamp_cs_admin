import 'package:equatable/equatable.dart';
import '../../data/models/cs_log_model.dart';

abstract class CsLogsState extends Equatable {
  const CsLogsState();
  @override
  List<Object> get props => [];
}

class CsLogsInitial extends CsLogsState {}

class CsLogsLoading extends CsLogsState {}

class CsLogsLoaded extends CsLogsState {
  final List<CsLogModel> logs;
  const CsLogsLoaded(this.logs);
  @override
  List<Object> get props => [logs];
}

class CsLogsError extends CsLogsState {
  final String message;
  const CsLogsError(this.message);
  @override
  List<Object> get props => [message];
}