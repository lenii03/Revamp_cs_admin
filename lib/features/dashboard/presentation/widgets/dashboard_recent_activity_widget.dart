import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';

class DashboardRecentActivityWidget extends StatelessWidget {
  const DashboardRecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.separatorDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Tabel
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Log Aktivitas CS Terbaru",
              style: TextStyle(
                color: AppColors.textColorDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: AppColors.separatorDark, height: 1),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 5, 
              separatorBuilder: (context, index) => const Divider(color: AppColors.separatorDark, height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryDark.withOpacity(0.1),
                    child: const Icon(Icons.person, color: AppColors.primaryDark),
                  ),
                  title: Text(
                    "CS_Leni_${index + 1}", 
                    style: const TextStyle(
                      color: AppColors.textColorDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    "Melakukan reset password user", 
                    style: TextStyle(color: AppColors.secondaryTextColorDark),
                  ),
                  trailing: const Text(
                    "Baru saja", 
                    style: TextStyle(
                      color: AppColors.secondaryTextColorDark,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}