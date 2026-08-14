import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/core/theme/theme_cubit.dart';
import 'package:el_csadmin/core/network/server_config.dart';
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
import '../../../features/reports/report_send_pwd_pin/presentation/pages/report_send_pwd_pin_page.dart';
import 'app_sidebar.dart';

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
    'report_send_pwd_pin': const ReportSendPwdPinPage(),
    'send_email_forgot': const SendEmailForgotPage(),
    'approve_opening': const ApproveOpeningAccountPage(),
    'notification': const NotificationPage(),
  };

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
    _loadServerUrl();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _appVersion = packageInfo.version);
    } catch (_) {
      if (!mounted) return;
      setState(() => _appVersion = 'Tidak tersedia');
    }
  }

  Future<void> _loadServerUrl() async {
    final serverUrl = await ServerConfig.getBaseUrl();
    if (!mounted) return;
    setState(() => _serverUrl = serverUrl.replaceFirst(RegExp(r'/$'), ''));
  }

  void _onMenuSelected(String route) {
    if (route == 'logout') return;
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
      // Logout lokal tetap harus berjalan walaupun server tidak dapat diakses.
    } finally {
      await sessionService.remove(SessionKey.token);
      await sessionService.remove(SessionKey.loginId);
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
    return Scaffold(
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
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
          onPressed: () => setState(() => _isSidebarOpen = !_isSidebarOpen),
        ),
        title: Row(
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
                label: _appVersion.isEmpty ? 'Versi …' : 'v$_appVersion',
              ),
            ],
            if (MediaQuery.sizeOf(context).width >= 900) ...[
              const SizedBox(width: 8),
              Flexible(
                child: _buildHeaderBadge(
                  context,
                  label: _serverUrl.isEmpty
                      ? 'Server belum dikonfigurasi'
                      : _serverUrl,
                  tooltip: _serverUrl.isEmpty
                      ? 'Alamat server belum dikonfigurasi'
                      : 'Server aktif: $_serverUrl',
                ),
              ),
            ],
          ],
        ),
        actions: [
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
              if (value == 'token') {
                /* TODO: Aksi Delete Token */
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
              PopupMenuItem(
                value: 'token',
                child: Text(
                  "Delete Token",
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
          const SizedBox(width: 16),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 800;
          final page =
              _pages[_selectedRoute] ??
              const Center(
                child: Text(
                  'Halaman sedang dalam pengembangan',
                  style: TextStyle(color: AppColors.secondaryTextColorDark),
                ),
              );

          if (!compact) {
            return Row(
              children: [
                if (_isSidebarOpen)
                  SizedBox(width: 260, child: _buildSidebar()),
                Expanded(child: page),
              ],
            );
          }

          final sidebarWidth = constraints.maxWidth.clamp(0, 260).toDouble();
          return Stack(
            children: [
              Positioned.fill(child: page),
              if (_isSidebarOpen)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => setState(() => _isSidebarOpen = false),
                    child: Container(color: Colors.black38),
                  ),
                ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: _isSidebarOpen ? 0 : -sidebarWidth,
                top: 0,
                bottom: 0,
                width: sidebarWidth,
                child: Material(
                  elevation: 12,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: _buildSidebar(closeAfterSelection: true),
                ),
              ),
            ],
          );
        },
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

  Widget _buildSidebar({bool closeAfterSelection = false}) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        shadowColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: SizedBox(
        width: 260,
        child: AppSidebar(
          isOpen: _isSidebarOpen,
          selectedRoute: _selectedRoute,
          onItemSelected: (route) {
            _onMenuSelected(route);
            if (closeAfterSelection && route != 'logout') {
              setState(() => _isSidebarOpen = false);
            }
          },
        ),
      ),
    );
  }
}
