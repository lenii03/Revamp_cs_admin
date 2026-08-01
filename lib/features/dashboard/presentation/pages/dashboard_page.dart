import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:el_csadmin/features/dashboard/presentation/widgets/dashboard_pending_approval_widget.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../../../../injector.dart';
import '../widgets/dashboard_metric_card.dart';
import '../widgets/dashboard_recent_activity_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              locator<ApprovalScreenBloc>()
                ..add(const ApprovalScreenEvent.fetchApprovals()),
        ),
        BlocProvider(
          create: (context) =>
              locator<DashboardBloc>()..add(FetchDashboardMetricsEvent()),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ringkasan Sistem",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 24),

            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                String totalCs = "0";
                String totalUserOnline = "0";
                String totalPending = "0";

                if (state is DashboardLoaded) {
                  totalCs = state.totalCs;
                  totalUserOnline = state.totalUserOnline;
                  totalPending = state.totalPending;
                } else if (state is DashboardLoading) {
                  totalCs = "...";
                  totalUserOnline = "...";
                  totalPending = "...";
                }

                return Row(
                  children: [
                    DashboardMetricCard(
                      title: "Total CS Aktif",
                      value: totalCs,
                      icon: Icons.support_agent,
                      iconColor: const Color(0xFF2EBDAD),
                      gradient: AppColors.tealGradient,
                    ),
                    const SizedBox(width: 16),

                    DashboardMetricCard(
                      title: "User Online",
                      value: totalUserOnline,
                      icon: Icons.public,
                      iconColor: const Color(0xFF7D43E0),
                      gradient: AppColors.purpleGradient,
                    ),
                    const SizedBox(width: 16),

                    DashboardMetricCard(
                      title: "Pending Approval",
                      value: totalPending,
                      icon: Icons.pending_actions,
                      iconColor: const Color(0xFFE97A44),
                      gradient: AppColors.orangeGradient,
                    ),
                  ],
                );
              },
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
