class ReportResetPinCodeModel {
  final String no;
  final String clientCode;
  final String clientName;
  final String requestDate;
  final String reason;
  final String validation1;
  final String validation2;
  final String approveBy;
  final String approveDate;

  ReportResetPinCodeModel({
    required this.no,
    required this.clientCode,
    required this.clientName,
    required this.requestDate,
    required this.reason,
    required this.validation1,
    required this.validation2,
    required this.approveBy,
    required this.approveDate,
  });

  factory ReportResetPinCodeModel.fromMap(Map<String, dynamic> map) {
    return ReportResetPinCodeModel(
      no: map['no']?.toString() ?? '-',
      clientCode: map['clientCode']?.toString() ?? '-',
      clientName: map['clientName']?.toString() ?? '-',
      requestDate: map['requestDate']?.toString() ?? '-',
      reason: map['reason']?.toString() ?? '-',
      validation1: map['validation1']?.toString() ?? '-',
      validation2: map['validation2']?.toString() ?? '-',
      approveBy: map['approveBy']?.toString() ?? '-',
      approveDate: map['approveDate']?.toString() ?? '-',
    );
  }
}

