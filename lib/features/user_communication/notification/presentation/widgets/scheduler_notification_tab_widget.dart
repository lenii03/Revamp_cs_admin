import 'package:el_csadmin/features/user_communication/notification/presentation/widgets/create_scheduler_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart';

class SchedulerNotificationTabWidget extends StatelessWidget {
  const SchedulerNotificationTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Ambil tema dinamis
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerBg = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final separatorColor = isDark
        ? AppColors.separatorDark
        : AppColors.separatorLight;
    final labelColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const CreateSchedulerDialog(),
            );
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'Add Scheduler',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor, // 👈 Seragam Cyan
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: containerBg, // 👈 Dinamis
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: separatorColor), // 👈 Dinamis
            ),
            child: Center(
              child: Text(
                "The Scheduler table (TrinaGrid) will appear here",
                style: TextStyle(color: labelColor), // 👈 Dinamis
              ),
            ),
          ),
        ),
      ],
    );
  }
}
