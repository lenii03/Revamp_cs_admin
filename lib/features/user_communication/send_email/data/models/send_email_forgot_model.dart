class SendEmailForgotModel {
  final int actionType;
  final String loginId;
  final String email;
  final int loginType;
  final String requestId;
  final String source;
  final String createdAt;
  int status;

  SendEmailForgotModel({
    required this.actionType,
    required this.loginId,
    required this.email,
    required this.loginType,
    required this.status,
    this.requestId = '',
    this.source = 'legacy',
    this.createdAt = '',
  });

  factory SendEmailForgotModel.fromJson(Map<String, dynamic> json) {
    return SendEmailForgotModel(
      actionType: int.tryParse(json['actionType']?.toString() ?? '') ?? 1,
      loginId: json['loginId']?.toString() ?? '-',
      email: json['email']?.toString() ?? '-',
      loginType: int.tryParse(json['loginType']?.toString() ?? '') ?? 1,
      status: int.tryParse(json['status']?.toString() ?? '') ?? 1,
      requestId: json['requestId']?.toString() ?? '',
      source: json['source']?.toString() ?? 'legacy',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': actionType,
      'loginId': loginId,
      'email': email,
      'loginType': loginType,
      'status': status,
      'requestId': requestId,
      'source': source,
      'createdAt': createdAt,
    };
  }
}
