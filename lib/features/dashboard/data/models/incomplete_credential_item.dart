class IncompleteCredentialItem {
  const IncompleteCredentialItem({
    required this.loginId,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.missingFields,
    required this.loginType,
    required this.accountExpired,
    required this.permissions,
    required this.status,
    required this.salesId,
  });

  final String loginId;
  final String email;
  final String phoneNumber;
  final String birthDate;
  final List<String> missingFields;
  final int loginType;
  final String accountExpired;
  final int permissions;
  final int status;
  final String salesId;
}
