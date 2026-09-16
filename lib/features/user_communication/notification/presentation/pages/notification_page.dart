import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart'; // Wajib ditambahkan untuk ThemeColors
import '../widgets/push_notification_tab_widget.dart';
import '../widgets/scheduler_notification_tab_widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final unselectedColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return DefaultTabController(
      length: 2, 
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Management',
              style: TextStyle(
                color: textColor, 
                fontSize: 22, 
              ),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: separatorColor),
                ), 
              ),
              child: TabBar(
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: unselectedColor,
                tabs: const [
                  Tab(text: "Push Notification"),
                  Tab(text: "Scheduler Notification"),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
