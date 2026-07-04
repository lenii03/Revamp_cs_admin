class OnlineIdModel {
  final dynamic accountExpired;
  final String approvedBy;
  final String emailApprovedAt;
  final String created;
  final String createdBy;
  final String email;
  final String handphoneNo;
  final String handphone;
  final String birthDate;
  final int errorPinRetry;
  final int errorPwdRetry;
  final String lastAcctLogin;
  final String lastLogin;
  final String lastModified;
  final String lastModifiedBy;
  final String lastPinChg;
  final String lastPasswordChg;
  final String loginId;
  final int loginType;
  final String pin;
  final String pinExpired;
  final String password;
  final int permissions;
  final dynamic pwdExpired;
  final String salesId;
  final int status;

  OnlineIdModel({
    this.accountExpired,
    required this.approvedBy,
    required this.emailApprovedAt,
    required this.created,
    required this.createdBy,
    required this.email,
    required this.handphoneNo,
    required this.handphone,
    required this.birthDate,
    required this.errorPinRetry,
    required this.errorPwdRetry,
    required this.lastAcctLogin,
    required this.lastLogin,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.lastPinChg,
    required this.lastPasswordChg,
    required this.loginId,
    required this.loginType,
    required this.pin,
    required this.pinExpired,
    required this.password,
    required this.permissions,
    required this.pwdExpired,
    required this.salesId,
    required this.status,
  });

  factory OnlineIdModel.fromMap(Map<String, dynamic> map) {
    // Ubah semua key API menjadi huruf kecil agar mudah dicari
    final lowerMap = map.map(
      (key, value) => MapEntry(key.toLowerCase(), value),
    );

    // 💡 Helper untuk mengatasi data null ATAU string kosong ("")
    String parseString(String key, String fallback) {
      final value = lowerMap[key]?.toString();
      if (value == null || value.trim().isEmpty) {
        return fallback;
      }
      return value;
    }

    return OnlineIdModel(
      // Menggunakan helper agar string "" otomatis berubah jadi "Never Expired"
      accountExpired: parseString('accountexpired', 'Never Expired'),
      approvedBy: parseString('approvedby', '-'),
      emailApprovedAt: parseString('emailapprovedat', '-'),
      loginId: parseString('loginid', '-'),
      created: parseString('created', '-'),
      createdBy: parseString('createdby', '-'),
      email: parseString('email', '-'),

      // 👈 INI KUNCI UTAMANYA: Mengambil data dari 'phonenumber' sesuai JSON Server
      handphoneNo: parseString('phonenumber', '-'),
      handphone: parseString('handphone', '-'),

      birthDate: parseString('birthdate', '-'),

      errorPinRetry:
          int.tryParse(lowerMap['errorpinretry']?.toString() ?? '0') ?? 0,
      errorPwdRetry:
          int.tryParse(lowerMap['errorpwdretry']?.toString() ?? '0') ?? 0,
      lastAcctLogin: parseString('lastacctlogin', '-'),
      lastLogin: parseString('lastlogin', '-'),
      lastModified: parseString('lastmodified', '-'),
      lastModifiedBy: parseString('lastmodifiedby', '-'),
      lastPinChg: parseString('lastpinchg', '-'),
      lastPasswordChg: parseString('lastpasswordchg', '-'),
      loginType: int.tryParse(lowerMap['logintype']?.toString() ?? '0') ?? 0,
      pin: parseString('pin', '-'),
      pinExpired: parseString('pinexpired', '-'),
      password: parseString('password', '-'),
      permissions:
          int.tryParse(lowerMap['permissions']?.toString() ?? '0') ?? 0,
      pwdExpired: lowerMap['pwdexpired'],
      salesId: parseString('salesid', '-'),
      status: int.tryParse(lowerMap['status']?.toString() ?? '0') ?? 0,
    );
  }
}
