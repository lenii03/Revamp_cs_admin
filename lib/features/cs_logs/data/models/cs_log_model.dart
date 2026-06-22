class CsLogModel {
  final String csLoginId;
  final String onlineLoginId;
  final String logTime;
  final String approvalId;
  final String logType;
  final String descriptions;

  CsLogModel({
    required this.csLoginId,
    required this.onlineLoginId,
    required this.logTime,
    required this.approvalId,
    required this.logType,
    required this.descriptions,
  });

  factory CsLogModel.fromMap(Map<String, dynamic> map) {
    return CsLogModel(
      csLoginId: map['CsLoginId']?.toString() ?? '-',
      onlineLoginId: map['OnlineLoginId']?.toString() ?? '-',
      logTime: map['LogTime']?.toString() ?? '-',
      approvalId: map['ApprovalId']?.toString() ?? '-',
      logType: map['LogType']?.toString() ?? '-',
      descriptions: map['Descriptions']?.toString() ?? '-',
    );
  }
}