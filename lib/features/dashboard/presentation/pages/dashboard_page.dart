import 'package:el_csadmin/features/dashboard/presentation/widgets/dashboard_pending_approval_widget.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 👇 Wajib ada import ini
import '../../../../core/theme/src/app_colors.dart';
import '../../../../injector.dart'; // 👇 Wajib untuk memanggil locator
import '../widgets/dashboard_metric_card.dart';
import '../widgets/dashboard_recent_activity_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<ApprovalScreenBloc>()..add(FetchApprovalsEvent()),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Sistem",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textColorDark,
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                DashboardMetricCard(
                  title: "Total CS Aktif",
                  value: "24",
                  icon: Icons.support_agent,
                  iconColor: Color(0xFF2EBDAD),
                  gradient: AppColors.tealGradient,
                ),
                SizedBox(width: 16),
                DashboardMetricCard(
                  title: "User Online",
                  value: "148",
                  icon: Icons.public,
                  iconColor: Color(0xFF7D43E0),
                  gradient: AppColors.purpleGradient,
                ),
                SizedBox(width: 16),
                DashboardMetricCard(
                  title: "Active Deals",
                  value: "36",
                  icon: Icons.handshake_outlined,
                  iconColor: Color(0xFFE97A44),
                  gradient: AppColors.orangeGradient,
                ),
                SizedBox(width: 16),
                DashboardMetricCard(
                  title: "Average ROI",
                  value: "142%",
                  icon: Icons.analytics,
                  iconColor: Color(0xFFD6358C),
                  gradient: AppColors.pinkGradient,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: DashboardPendingApprovalWidget()),
                  SizedBox(width: 24),
                  Expanded(flex: 4, child: DashboardRecentActivityWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
