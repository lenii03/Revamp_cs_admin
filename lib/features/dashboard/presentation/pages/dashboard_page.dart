import 'package:flutter/material.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../widgets/dashboard_metric_card.dart';
import '../widgets/dashboard_recent_activity_widget.dart';
import '../widgets/dashboard_activity_chart.dart'; // Import grafiknya

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
                gradient:
                    AppColors.purpleGradient,
              ),
              SizedBox(width: 16),
              DashboardMetricCard(
                title: "Active Deals",
                value: "36",
                icon: Icons.handshake_outlined,
                iconColor: Color(0xFFE97A44),
                gradient:
                    AppColors.orangeGradient, 
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
                Expanded(flex: 6, child: DashboardActivityChart()),
                SizedBox(width: 24),
                Expanded(flex: 4, child: DashboardRecentActivityWidget()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
