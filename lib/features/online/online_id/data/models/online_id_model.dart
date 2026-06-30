class OnlineIdModel {
  final String loginId;
  final String email;
  final String approvedAt;
  final String hp;
  final String birth;
  final String type;
  final String status;
  final String pwdRetry;
  final String pinRetry;

  OnlineIdModel({
    required this.loginId,
    required this.email,
    required this.approvedAt,
    required this.hp,
    required this.birth,
    required this.type,
    required this.status,
    required this.pwdRetry,
    required this.pinRetry,
  });

  factory OnlineIdModel.fromMap(Map<String, dynamic> map) {
    return OnlineIdModel(
      loginId: map['loginId']?.toString() ?? '-',
      email: map['email']?.toString() ?? '-',
      approvedAt: map['approvedAt']?.toString() ?? '-',
      hp: map['hp']?.toString() ?? '-',
      birth: map['birth']?.toString() ?? '-',
      type: map['type']?.toString() ?? '-',
      status: map['status']?.toString() ?? '-',
      pwdRetry: map['pwdRetry']?.toString() ?? '0',
      pinRetry: map['pinRetry']?.toString() ?? '0',
    );
  }
}