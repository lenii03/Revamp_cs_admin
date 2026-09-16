import 'package:equatable/equatable.dart';

class ManageCsUser extends Equatable {
  const ManageCsUser({
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

  bool get hasApprove => (permissions & 1) != 0;
  bool get hasDemo => (permissions & 2) != 0;
  bool get hasCsLogs => (permissions & 4) != 0;
  bool get hasOpeningAccount => (permissions & 8) != 0;
  bool get hasReports => (permissions & 16) != 0;
  bool get hasSendDisclaimer => (permissions & 32) != 0;
  bool get hasCustomerRatio => (permissions & 64) != 0;

  @override
  List<Object> get props => [
    loginId,
    employeeId,
    email,
    isActive,
    isCs,
    isOnline,
    permissions,
    created,
    lastModified,
    lastLogin,
    createdBy,
    modifiedBy,
  ];
}
