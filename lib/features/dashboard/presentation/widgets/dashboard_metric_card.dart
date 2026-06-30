import 'package:flutter/material.dart';
import '../../../../core/theme/src/app_colors.dart';

class DashboardMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Gradient? gradient;

  const DashboardMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasGradient = gradient != null;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: gradient,
          color: hasGradient ? null : AppColors.systemGroupedBackgroundDark,
          borderRadius: BorderRadius.circular(16),
          // Beri border tipis transparan jika pakai gradasi
          border: Border.all(
            color: hasGradient
                ? Colors.white.withValues(alpha: 0.1)
                : AppColors.separatorDark,
            width: 1,
          ),
          boxShadow: hasGradient
              ? [
                  BoxShadow(
                    color: iconColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // Jika pakai gradasi, background icon jadi putih transparan
                color: hasGradient
                    ? Colors.white.withValues(alpha: 0.2)
                    : iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                // Ikon menjadi putih jika backgroundnya gradasi
                color: hasGradient ? Colors.white : iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),

            // Teks Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      // Teks title agak redup sedikit
                      color: hasGradient
                          ? Colors.white.withValues(alpha: 0.8)
                          : AppColors.secondaryTextColorDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      // Teks value putih tebal
                      color: hasGradient
                          ? Colors.white
                          : AppColors.textColorDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
