class SendEmailForgotModel {
  final String action;
  final String loginId;
  final String email;
  final String loginType;
  final String status;

  SendEmailForgotModel({
    required this.action,
    required this.loginId,
    required this.email,
    required this.loginType,
    required this.status,
  });
}