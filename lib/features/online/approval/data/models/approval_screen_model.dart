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
  final String handphoneNo;
  final String birthDate;

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
    required this.handphoneNo,
    required this.birthDate,
  });

  factory ApprovalScreenModel.fromMap(Map<String, dynamic> map) {
    final lowerMap = map.map(
      (key, value) => MapEntry(key.toLowerCase(), value),
    );

    String parseString(String key, String fallback) {
      final value = lowerMap[key]?.toString();
      if (value == null || value.trim().isEmpty) return fallback;
      return value;
    }

    String getAction(String type) {
      if (type == '1') return 'Add';
      if (type == '2') return 'Edit';
      if (type == '3') return 'Delete';
      return '-';
    }

    String getStatus(String status) {
      if (status == '1') return 'Pending';
      if (status == '2') return 'Approved';
      if (status == '0' || status == '3') return 'Rejected';
      return '-';
    }

    return ApprovalScreenModel(
      action: getAction(parseString('actiontype', '0')),
      loginId: parseString('loginid', '-'),
      email: parseString('email', '-'),
      loginType: parseString('logintype', '0'),
      status: getStatus(parseString('status', '-')),
      accountExpired: parseString('accountexpired', 'Never Expired'),
      salesBranchId: parseString('salesid', '-'),
      createdBy: parseString('createdby', '-'),
      permissions: parseString('permissions', '0'),
      approvalId: parseString('approvalid', '-'),

      // 💡 Mengambil data untuk Popup
      handphoneNo: parseString('phonenumber', '-'),
      birthDate: parseString('birthdate', '-'),
    );
  }
}
