import 'dart:convert';

class LoginUserModel {
  String loginId;
  String employeeId;
  String email;
  int status;
  int permissions;
  int? createCsLogin;
  int? createUserLogin;
  int? approveUserLogin;
  int? createDemoAccount;
  int? viewCsLogs;
  int? approvalOpeningAccount;
  int? viewReports;
  int? sendOlUserDisc;
  int? viewCusRatio;

  LoginUserModel({
    this.loginId = '',
    this.employeeId = '',
    this.email = '',
    this.status = 0,
    this.permissions = 0,
  }) {
    _parsePermissions();
  }

  void _parsePermissions() {
    createCsLogin = (permissions & (1 << 0)) != 0 ? 1 : 0;
    createUserLogin = (permissions & (1 << 1)) != 0 ? 1 : 0;
    approveUserLogin = (permissions & (1 << 2)) != 0 ? 1 : 0;
    createDemoAccount = (permissions & (1 << 3)) != 0 ? 1 : 0;
    viewCsLogs = (permissions & (1 << 4)) != 0 ? 1 : 0;
    approvalOpeningAccount = (permissions & (1 << 5)) != 0 ? 1 : 0;
    viewReports = (permissions & (1 << 6)) != 0 ? 1 : 0;
    sendOlUserDisc = (permissions & (1 << 7)) != 0 ? 1 : 0;
    viewCusRatio = (permissions & (1 << 8)) != 0 ? 1 : 0;
  }

  void _updatePermissions() {
    permissions = 0;
    if (createCsLogin == 1) permissions |= (1 << 0);
    if (createUserLogin == 1) permissions |= (1 << 1);
    if (approveUserLogin == 1) permissions |= (1 << 2);
    if (createDemoAccount == 1) permissions |= (1 << 3);
    if (viewCsLogs == 1) permissions |= (1 << 4);
    if (approvalOpeningAccount == 1) permissions |= (1 << 5);
    if (viewReports == 1) permissions |= (1 << 6);
    if (sendOlUserDisc == 1) permissions |= (1 << 7);
    if (viewCusRatio == 1) permissions |= (1 << 8);
  }

  Map<String, dynamic> toMap() {
    _updatePermissions();
    return <String, dynamic>{
      'LoginId': loginId,
      'EmployeeId': employeeId,
      'Email': email,
      'Status': status,
      'Permissions': permissions,
    };
  }

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    LoginUserModel user = LoginUserModel(
      loginId: map['LoginId'] ?? '',
      employeeId: map['EmployeeId'] ?? '',
      email: map['Email'] ?? '',
      status: map['Status'] ?? 0,
      permissions: map['Permissions'] ?? 0,
    );
    user._parsePermissions();
    return user;
  }

  String toJson() => json.encode(toMap());

  factory LoginUserModel.fromJson(String source) =>
      LoginUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
