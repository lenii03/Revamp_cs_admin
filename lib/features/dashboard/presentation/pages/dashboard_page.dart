import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:el_csadmin/features/dashboard/presentation/widgets/dashboard_pending_approval_widget.dart';
import 'package:el_csadmin/features/dashboard/presentation/widgets/incomplete_credentials_dialog.dart';
import 'package:el_csadmin/features/dashboard/data/models/incomplete_credential_item.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
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
          create: (context) {
            final bloc = locator<ApprovalScreenBloc>();
            bloc.applyFilters(status: 1);
            return bloc;
          },
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
              "System Summary",
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
                String totalCs = "—";
                String totalUserOnline = "—";
                String totalPending = "—";
                String incompleteCredentials = "—";
                List<IncompleteCredentialItem> incompleteUsers = const [];
                Map<String, String> metricErrors = const {};

                if (state is DashboardLoaded) {
                  totalCs = state.totalCs;
                  totalUserOnline = state.totalUserOnline;
                  totalPending = state.totalPending;
                  incompleteCredentials = state.incompleteCredentials;
                  incompleteUsers = state.incompleteCredentialUsers;
                  metricErrors = state.errors;
                } else if (state is DashboardLoading) {
                  totalCs = "...";
                  totalUserOnline = "...";
                  totalPending = "...";
                  incompleteCredentials = "...";
                }

                Widget totalCsCard() => DashboardMetricCard(
                      title: "Total CS",
                      value: totalCs,
                      errorMessage: metricErrors['totalCs'],
                      icon: Icons.support_agent,
                      iconColor: const Color(0xFF2EBDAD),
                      gradient: AppColors.tealGradient,
                    );
                Widget totalOnlineCard() => DashboardMetricCard(
                      title: "Total Online ID",
                      value: totalUserOnline,
                      errorMessage: metricErrors['totalOnlineId'],
                      icon: Icons.public,
                      iconColor: const Color(0xFF7D43E0),
                      gradient: AppColors.purpleGradient,
                    );
                Widget pendingCard() => DashboardMetricCard(
                      title: "Pending Approval",
                      value: totalPending,
                      errorMessage: metricErrors['totalPending'],
                      icon: Icons.pending_actions,
                      iconColor: const Color(0xFFE97A44),
                      gradient: AppColors.orangeGradient,
                    );
                Widget incompleteCard() => DashboardMetricCard(
                      title: "Incomplete Credentials",
                      value: incompleteCredentials,
                      errorMessage: metricErrors['incompleteCredentials'],
                      icon: Icons.contact_page_outlined,
                      iconColor: const Color(0xFFD81B60),
                      gradient: AppColors.pinkGradient,
                      onViewDetails: state is DashboardLoaded &&
                              metricErrors['incompleteCredentials'] == null
                          ? () {
                              showDialog<void>(
                                context: context,
                                builder: (_) => IncompleteCredentialsDialog(
                                  users: incompleteUsers,
                                  onUpdated: () {
                                    Future<void>.delayed(
                                      const Duration(milliseconds: 500),
                                      () {
                                        if (!context.mounted) return;
                                        context
                                            .read<ApprovalScreenBloc>()
                                            .applyFilters(status: 1);
                                        context.read<DashboardBloc>().add(
                                          FetchDashboardMetricsEvent(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                          : null,
                    );

                return LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 900) {
                      return Row(
                        children: [
                          totalCsCard(),
                          const SizedBox(width: 16),
                          totalOnlineCard(),
                          const SizedBox(width: 16),
                          pendingCard(),
                          const SizedBox(width: 16),
                          incompleteCard(),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Row(
                          children: [
                            totalCsCard(),
                            const SizedBox(width: 16),
                            totalOnlineCard(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            pendingCard(),
                            const SizedBox(width: 16),
                            incompleteCard(),
                          ],
                        ),
                      ],
                    );
                  },
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
