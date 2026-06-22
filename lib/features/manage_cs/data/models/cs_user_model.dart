class CsUserModel {
  final String loginId;
  final String employeeId;
  final String email;
  final bool isActive;
  final bool isCs;
  final bool isOnline;

  CsUserModel({
    required this.loginId,
    required this.employeeId,
    required this.email,
    required this.isActive,
    required this.isCs,
    required this.isOnline,
  });

  factory CsUserModel.fromMap(Map<String, dynamic> map) {
    return CsUserModel(
      loginId: map['LoginId'] ?? map['login_id'] ?? '-',
      employeeId: map['EmployeeId'] ?? map['employee_id'] ?? '-',
      email: map['Email'] ?? map['email'] ?? '-',
      // Anggap data dari server bernilai 1/true untuk aktif, dan 0/false untuk non-aktif
      isActive: map['Active'] == 1 || map['Active'] == true || map['Active'] == 'Y',
      isCs: map['CS'] == 1 || map['CS'] == true || map['CS'] == 'Y',
      isOnline: map['Online'] == 1 || map['Online'] == true || map['Online'] == 'Y',
    );
  }
}