class SendEmailForgotModel {
  final int actionType;
  final String loginId;
  final String email;
  final int loginType;
  int status;

  SendEmailForgotModel({
    required this.actionType,
    required this.loginId,
    required this.email,
    required this.loginType,
    required this.status,
  });

  factory SendEmailForgotModel.fromJson(Map<String, dynamic> json) {
    return SendEmailForgotModel(
      actionType: json['actionType'] as int,
      loginId: json['loginId'] as String,
      email: json['email'] as String,
      loginType: json['loginType'] as int,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': actionType,
      'loginId': loginId,
      'email': email,
      'loginType': loginType,
      'status': status,
    };
  }
}
