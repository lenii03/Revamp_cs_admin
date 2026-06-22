import 'package:flutter/material.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../widgets/dashboard_metric_card.dart';
import '../widgets/dashboard_recent_activity_widget.dart'; // Import tabelnya

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                value: "12",
                icon: Icons.support_agent,
                iconColor: AppColors.primaryDark,
              ),
              SizedBox(width: 16),
              DashboardMetricCard(
                title: "User Online",
                value: "148",
                icon: Icons.public,
                iconColor: AppColors
                    .systemGreenDark,
              ),
              SizedBox(width: 16),
              DashboardMetricCard(
                title: "Log Aktivitas (Hari Ini)",
                value: "1,024",
                icon: Icons.history,
                iconColor: AppColors.systemOrangeDark,
              ),
            ],
          ),

          const SizedBox(height: 32),

          const Expanded(
            child: DashboardRecentActivityWidget(),
          ),
        ],
      ),
    );
  }
}
