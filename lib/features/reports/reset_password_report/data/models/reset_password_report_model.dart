class ResetPasswordReportModel {
  final String clientCode;
  final String clientName;
  final String requestDate;
  final String reason;
  final String createBy;
  final String createDate;
  final String approveBy;
  final String approveDate;

  ResetPasswordReportModel({
    required this.clientCode,
    required this.clientName,
    required this.requestDate,
    required this.reason,
    required this.createBy,
    required this.createDate,
    required this.approveBy,
    required this.approveDate,
  });
}