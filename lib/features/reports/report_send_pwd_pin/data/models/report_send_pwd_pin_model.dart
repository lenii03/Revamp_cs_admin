class ReportSendPwdPinModel {
  final String no;
  final String clientCode;
  final String clientName;
  final String createBy;
  final String createDate;
  final String approveBy;
  final String approveDate;

  ReportSendPwdPinModel({
    required this.no,
    required this.clientCode,
    required this.clientName,
    required this.createBy,
    required this.createDate,
    required this.approveBy,
    required this.approveDate,
  });

  factory ReportSendPwdPinModel.fromMap(Map<String, dynamic> map) {
    return ReportSendPwdPinModel(
      no: map['no']?.toString() ?? '-',
      clientCode: map['clientCode']?.toString() ?? '-',
      clientName: map['clientName']?.toString() ?? '-',
      createBy: map['createBy']?.toString() ?? '-',
      createDate: map['createDate']?.toString() ?? '-',
      approveBy: map['approveBy']?.toString() ?? '-',
      approveDate: map['approveDate']?.toString() ?? '-',
    );
  }
}