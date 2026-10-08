import '../../data/local/session_service.dart';
import '../../injector.dart';

enum AppPermission {
  createCsLogin(0),
  createOnlineUser(1),
  approveOnlineUser(2),
  createDemoAccount(3),
  viewCsLogs(4),
  approvalOpeningAccount(5),
  viewReports(6),
  sendOlUserDisclaimer(7),
  viewCustomerRatio(8);

  const AppPermission(this.bit);

  final int bit;
}

class AppPermissionGate {
  AppPermissionGate._();

  static int get value =>
      int.tryParse(locator<SessionService>().read(SessionKey.permissions)) ?? 0;

  static bool has(AppPermission permission) =>
      (value & (1 << permission.bit)) != 0;

  static bool get canManageCs => has(AppPermission.createCsLogin);
  static bool get canViewCsLogs => has(AppPermission.viewCsLogs);
  static bool get canCreateOnlineUsers => has(AppPermission.createOnlineUser);
  static bool get canCreateDemoAccounts => has(AppPermission.createDemoAccount);
  static bool get canAccessOnlineUsers =>
      canCreateOnlineUsers || canCreateDemoAccounts;
  static bool get canApproveOnlineUsers =>
      has(AppPermission.approveOnlineUser);

  static bool canAccessRoute(String route) {
    return switch (route) {
      'manage_cs' => canManageCs,
      'show_cs_logs' => canViewCsLogs,
      'create_online_id' => canAccessOnlineUsers,
      'approval_screen' => canApproveOnlineUsers,
      _ => true,
    };
  }
}
