import 'package:el_csadmin/features/cs/cs_logs/presentation/pages/show_cs_logs_page.dart';
import 'package:el_csadmin/features/online/online_id/presentation/pages/create_online_id_page.dart';
import 'package:el_csadmin/features/reports/reset_password_report/presentation/pages/reset_password_report_page.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/src/app_colors.dart';
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

  final Map<String, Widget> _pages = {
    'dashboard': const DashboardPage(),
    'manage_cs': const ManageCsPage(),
    'show_cs_logs': const ShowCsLogsPage(),
    'create_online_id': const CreateOnlineIdPage(),
    'approval_screen': const ApprovalScreenPage(),
    'report_reset_pw': const ResetPasswordReportPage(),
    // 'report_reset_pin': const ReportResetPinCodePage(),
    'report_send_pwd_pin': const ReportSendPwdPinPage(),
  };

  void _onMenuSelected(String route) {
    if (route == 'logout') {
      return;
    }

    setState(() {
      _selectedRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.systemBackgroundDark,
      body: Row(
        children: [
          AppSidebar(
            selectedRoute: _selectedRoute,
            onItemSelected: _onMenuSelected,
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
