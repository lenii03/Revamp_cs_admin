import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/core/theme/theme_cubit.dart';
import 'package:el_csadmin/core/network/server_config.dart';
import 'package:el_csadmin/core/authorization/app_permission.dart';
import 'package:el_csadmin/core/notifications/dashboard_notification_center.dart';
import 'package:el_csadmin/core/window_manager/windows_manage_helper.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/data/repositories/login_repository.dart';
import 'package:el_csadmin/features/authentication/presentation/pages/login_page.dart';
import 'package:el_csadmin/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/theme/src/app_colors.dart';
import '../../../features/cs/cs_logs/presentation/pages/show_cs_logs_page.dart';
import '../../../features/online/online_id/presentation/pages/create_online_id_page.dart';
import '../../../features/user_communication/approve_opening/presentation/pages/approve_opening_account_page.dart';
import '../../../features/user_communication/notification/presentation/pages/notification_page.dart';
import '../../../features/user_communication/send_email/presentation/pages/send_email_forgot_page.dart';
import '../../../features/online/approval/presentation/pages/approval_screen_page.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../../features/cs/manage_cs/presentation/pages/manage_cs_page.dart';
import 'app_sidebar.dart';
import '../app_drag_to_move_area.dart';
import '../app_window_controls.dart';
import '../app_window_resize_frame.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String _selectedRoute = 'dashboard';
  bool _isSidebarOpen = true;
  bool _isLoggingOut = false;
  String _appVersion = '';
  String _serverUrl = '';

  final Map<String, Widget> _pages = {
    'dashboard': const DashboardPage(),
    'manage_cs': const ManageCsPage(),
    'show_cs_logs': const ShowCsLogsPage(),
    'create_online_id': const CreateOnlineIdPage(),
    'approval_screen': const ApprovalScreenPage(),
    'send_email_forgot': const SendEmailForgotPage(),
    'approve_opening': const ApproveOpeningAccountPage(),
    'notification': const NotificationPage(),
  };

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    _loadServerUrl();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await WindowsManageHelper.setMainWindow();
      }
    });
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _appVersion = packageInfo.version);
    } catch (_) {
      if (!mounted) return;
      setState(() => _appVersion = 'Unavailable');
    }
  }

  Future<void> _loadServerUrl() async {
    final serverUrl = await ServerConfig.getBaseUrl();
    if (!mounted) return;
    setState(() => _serverUrl = serverUrl.replaceFirst(RegExp(r'/$'), ''));
  }

  void _onMenuSelected(String route) {
    if (route == 'logout') return;
    if (!AppPermissionGate.canAccessRoute(route)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You do not have permission to access this feature.'),
        backgroundColor: AppColors.destructiveRedDark,
        behavior: SnackBarBehavior.floating,
      ),
      );
      return;
    }
    setState(() => _selectedRoute = route);
  }

  Future<void> _logout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    final sessionService = locator<SessionService>();
    final loginId = sessionService.read(SessionKey.loginId);

    try {
      if (loginId.isNotEmpty) {
        await locator<LoginRepository>().logOut({'LoginId': loginId});
      }
    } catch (_) {
    } finally {
      await sessionService.remove(SessionKey.token);
      await sessionService.remove(SessionKey.loginId);
      await sessionService.remove(SessionKey.permissions);
      await sessionService.remove(SessionKey.password);

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (_) => const LoginPage()),
          (_) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppWindowResizeFrame(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: 1.0,
          ),
        ),
            title: AppDragToMoveArea(
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
            Flexible(
              child: Text(
                "CS Admin",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).extension<ThemeTextStyles>()?.appTitle,
              ),
            ),
            if (MediaQuery.sizeOf(context).width >= 650) ...[
              const SizedBox(width: 12),
              _buildHeaderBadge(
                context,
                label: _appVersion.isEmpty ? 'Version …' : 'v$_appVersion',
              ),
            ],
            if (MediaQuery.sizeOf(context).width >= 900) ...[
              const SizedBox(width: 8),
              Flexible(
                child: _buildHeaderBadge(
                  context,
                  label: _serverUrl.isEmpty
                      ? 'Server not configured'
                      : _serverUrl,
                  tooltip: _serverUrl.isEmpty
                      ? 'Server address is not configured'
                      : 'Active server: $_serverUrl',
                ),
              ),
            ],
                  ],
                ),
              ),
            ),
            actions: [
          ValueListenableBuilder<List<DashboardNotificationItem>>(
            valueListenable:
                DashboardNotificationCenter.instance.notifications,
            builder: (context, notifications, child) {
              return PopupMenuButton<void>(
                tooltip: 'Action notifications',
                position: PopupMenuPosition.under,
                color: Theme.of(context)
                    .extension<ThemeColors>()
                    ?.appContainerBackground,
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    if (notifications.isNotEmpty)
                      Positioned(
                        right: -5,
                        top: -5,
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 16),
                          height: 16,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.destructiveRedDark,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text(
                            notifications.length > 9
                                ? '9+'
                                : '${notifications.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<void>(
                    enabled: false,
                    padding: EdgeInsets.zero,
                    child: SizedBox(
                      width: 360,
                      child: _NotificationHistoryPanel(
                        notifications: notifications,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
            color: Theme.of(
              context,
            ).extension<ThemeColors>()?.appContainerBackground,
            position: PopupMenuPosition.under,
            onSelected: (value) {
              if (value == 'theme') {
                context.read<ThemeCubit>().toggleTheme();
              }
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'theme',
                child: Text(
                  "Switch Theme",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              const PopupMenuDivider(height: 1),
              const PopupMenuItem(
                value: 'logout',
                child: Text(
                  "Log Out",
                  style: TextStyle(color: AppColors.destructiveRedDark),
                ),
              ),
            ],
          ),
          const AppWindowControls(),
            ],
        ),

        body: Row(
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(end: _isSidebarOpen ? 260 : 60),
              builder: (context, sidebarWidth, _) {
                final showLabels = sidebarWidth >= 190;
                return SizedBox(
                  width: sidebarWidth,
                  child: RepaintBoundary(
                    child: _buildSidebar(
                      isExpanded: showLabels,
                      expandedWidth: sidebarWidth,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: RepaintBoundary(
                child: !AppPermissionGate.canAccessRoute(_selectedRoute)
                    ? const _PermissionDeniedPage()
                    : _pages[_selectedRoute] ??
                    const Center(
                      child: Text(
                        'This page is under development',
                        style: TextStyle(
                          color: AppColors.secondaryTextColorDark,
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBadge(
    BuildContext context, {
    required String label,
    String? tooltip,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final badge = Container(
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryDark.withValues(alpha: isDark ? 0.1 : 0.07),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.primaryDark,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );

    return Tooltip(message: tooltip ?? label, child: badge);
  }

  Widget _buildSidebar({
    bool isExpanded = true,
    double expandedWidth = 260,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: SizedBox(
        width: expandedWidth,
        child: AppSidebar(
          isOpen: isExpanded,
          expandedWidth: expandedWidth,
          selectedRoute: _selectedRoute,
          onExpandRequested: () => setState(() => _isSidebarOpen = true),
          onToggleRequested: () => setState(() => _isSidebarOpen = !_isSidebarOpen),
          onItemSelected: (route) {
            _onMenuSelected(route);
          },
        ),
      ),
    );
  }
}

class _PermissionDeniedPage extends StatelessWidget {
  const _PermissionDeniedPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'You do not have permission to access this feature.',
        style: TextStyle(
          color: Theme.of(context).extension<ThemeColors>()?.unselectedLabel,
        ),
      ),
    );
  }
}

class _NotificationHistoryPanel extends StatelessWidget {
  const _NotificationHistoryPanel({required this.notifications});

  final List<DashboardNotificationItem> notifications;

  String _formatTime(DateTime value) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');
    return '${twoDigits(value.hour)}:${twoDigits(value.minute)}:${twoDigits(value.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final separatorColor = Theme.of(context).colorScheme.outlineVariant;
    final secondaryColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Action History',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (notifications.isNotEmpty)
                TextButton(
                  onPressed: DashboardNotificationCenter.instance.clear,
                  child: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
        Divider(height: 1, color: separatorColor),
        if (notifications.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: secondaryColor,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                    'No action notifications yet.',
                  style: TextStyle(color: secondaryColor, fontSize: 12),
                ),
              ],
            ),
          )
        else
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 360),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: notifications.length,
              separatorBuilder: (_, index) => Divider(
                height: 1,
                indent: 48,
                color: separatorColor,
              ),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final success =
                    notification.type == DashboardNotificationType.success;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        success
                            ? Icons.check_circle_outline
                            : Icons.error_outline,
                        size: 20,
                        color: success
                            ? const Color(0xFF2EBDAD)
                            : const Color(0xFFFF647C),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.message,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTime(notification.createdAt),
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
