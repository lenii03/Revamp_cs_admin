class ApprovalScreenModel {
  final String action;
  final String loginId;
  final String email;
  final String loginType;
  final String status;
  final String accountExpired;
  final String salesBranchId;
  final String createdBy;
  final String permissions;
  final String approvalId;

  ApprovalScreenModel({
    required this.action,
    required this.loginId,
    required this.email,
    required this.loginType,
    required this.status,
    required this.accountExpired,
    required this.salesBranchId,
    required this.createdBy,
    required this.permissions,
    required this.approvalId,
  });

  factory ApprovalScreenModel.fromMap(Map<String, dynamic> map) {
    return ApprovalScreenModel(
      action: map['action']?.toString() ?? '-',
      loginId: map['loginId']?.toString() ?? '-',
      email: map['email']?.toString() ?? '-',
      loginType: map['loginType']?.toString() ?? '-',
      status: map['status']?.toString() ?? '-',
      accountExpired: map['accountExpired']?.toString() ?? '-',
      salesBranchId: map['salesBranchId']?.toString() ?? '-',
      createdBy: map['createdBy']?.toString() ?? '-',
      permissions: map['permissions']?.toString() ?? '0',
      approvalId: map['approvalId']?.toString() ?? '-',
    );
  }
}