import 'package:equatable/equatable.dart';

abstract class CsLogsEvent extends Equatable {
  const CsLogsEvent();
  @override
  List<Object> get props => [];
}

class FetchCsLogsEvent extends CsLogsEvent {
  final String? loginId;
  final String? targetId;
  final int? logType;
  final int? page;
  final int? perPage;

  const FetchCsLogsEvent({
    this.loginId,
    this.targetId,
    this.logType,
    this.page,
    this.perPage,
  });

  @override
  List<Object> get props => [
    loginId ?? '',
    targetId ?? '',
    logType ?? -1,
    page ?? 1,
    perPage ?? 30,
  ];
}
