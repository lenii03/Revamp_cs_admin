import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart'; // Wajib ditambahkan untuk ThemeColors
import '../widgets/push_notification_tab_widget.dart';
import '../widgets/scheduler_notification_tab_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Ambil tema dinamis
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final unselectedColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Management',
              style: TextStyle(
                color: textColor, // 👈 Dinamis
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // TabBar Menu
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: separatorColor),
                ), // 👈 Dinamis
              ),
              child: TabBar(
                indicatorColor: AppColors.primaryColor, // 👈 Seragam Cyan
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: unselectedColor, // 👈 Dinamis
                tabs: const [
                  Tab(text: "Push Notification"),
                  Tab(text: "Scheduler Notification"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Isi Konten Tab
            const Expanded(
              child: TabBarView(
                children: [
                  PushNotificationTabWidget(),
                  SchedulerNotificationTabWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
