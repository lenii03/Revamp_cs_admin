class ManageCsUsersModel {
  final String loginId;
  final String employeeId;
  final String email;
  final bool isActive;
  final bool isCs;
  final bool isOnline;
  final int permissions;
  final String created;
  final String lastModified;
  final String lastLogin;
  final String createdBy;
  final String modifiedBy;

  ManageCsUsersModel({
    required this.loginId,
    required this.employeeId,
    required this.email,
    required this.isActive,
    required this.isCs,
    required this.isOnline,
    required this.permissions,
    required this.created,
    required this.lastModified,
    required this.lastLogin,
    required this.createdBy,
    required this.modifiedBy,
  });

  factory ManageCsUsersModel.fromMap(Map<String, dynamic> map) {
    return ManageCsUsersModel(
      loginId: map['LoginId'] ?? map['login_id'] ?? '-',
      employeeId: map['EmployeeId'] ?? map['employee_id'] ?? '-',
      email: map['Email'] ?? map['email'] ?? '-',
      isActive:
          map['Active'] == 1 || map['Active'] == true || map['Active'] == 'Y',
      isCs: map['CS'] == 1 || map['CS'] == true || map['CS'] == 'Y',
      isOnline:
          map['Online'] == 1 || map['Online'] == true || map['Online'] == 'Y',
      permissions: map['Permissions'] ?? map['permissions'] ?? 0,
      created: map['Created'] ?? map['created'] ?? '-',
      lastModified: map['LastModified'] ?? map['lastModified'] ?? '-',
      lastLogin: map['LastLogin'] ?? map['lastLogin'] ?? '-',
      createdBy: map['CreatedBy'] ?? map['createdBy'] ?? '-',
      modifiedBy: map['ModifiedBy'] ?? map['modifiedBy'] ?? '-',
    );
  }

  bool get hasApprove => (permissions & 1) != 0;
  bool get hasDemo => (permissions & 2) != 0;
  bool get hasCsLogs => (permissions & 4) != 0;
  bool get hasOpeningAccount => (permissions & 8) != 0;
  bool get hasReports => (permissions & 16) != 0;
  bool get hasSendDisclaimer => (permissions & 32) != 0;
  bool get hasCustomerRatio => (permissions & 64) != 0;
}
