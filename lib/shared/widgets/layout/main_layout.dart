import 'package:el_csadmin/core/theme/theme.dart';
import 'package:el_csadmin/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _onMenuSelected(String route) {
    if (route == 'logout') return;
    setState(() => _selectedRoute = route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.separatorDark, height: 1.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
          onPressed: () => setState(() => _isSidebarOpen = !_isSidebarOpen),
        ),
        title: Text(
          "CS Admin Dashboard",
          style: Theme.of(context).extension<ThemeTextStyles>()?.appTitle,
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
                /* TODO: Aksi Log Out */
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

      body: Row(
        children: [
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              shadowColor: Colors.transparent,

              splashFactory: NoSplash.splashFactory,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: _isSidebarOpen ? 260 : 0,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topLeft,
                  maxWidth: 260,
                  minWidth: 260,
                  child: AppSidebar(
                    isOpen: _isSidebarOpen,
                    selectedRoute: _selectedRoute,
                    onItemSelected: _onMenuSelected,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _pages[_selectedRoute] ??
                const Center(
                  child: Text(
                    "Halaman sedang dalam pengembangan",
                    style: TextStyle(color: AppColors.secondaryTextColorDark),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
