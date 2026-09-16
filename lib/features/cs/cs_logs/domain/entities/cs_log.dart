import 'package:equatable/equatable.dart';

class CsLog extends Equatable {
  const CsLog({
    required this.csLoginId,
    required this.onlineLoginId,
    required this.logTime,
    required this.approvalId,
    required this.logType,
    required this.descriptions,
  });

  final String csLoginId;
  final String onlineLoginId;
  final String logTime;
  final String approvalId;
  final String logType;
  final String descriptions;

  @override
  List<Object> get props => [
    csLoginId,
    onlineLoginId,
    logTime,
    approvalId,
    logType,
    descriptions,
  ];
}
