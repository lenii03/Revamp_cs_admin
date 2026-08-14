import 'package:flutter/material.dart';
import '../../../../core/theme/src/app_colors.dart';
import '../../../../core/theme/theme.dart';

class DashboardMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Gradient? gradient;
  final String? errorMessage;

  const DashboardMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.gradient,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasGradient = gradient != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: gradient,
          color: hasGradient
              ? null
              : Theme.of(
                  context,
                ).extension<ThemeColors>()?.appContainerBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasGradient
                ? Colors.white.withValues(alpha: 0.1)
                : (isDark ? AppColors.separatorDark : AppColors.separatorLight),
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
                color: hasGradient
                    ? Colors.white.withValues(alpha: 0.2)
                    : iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: hasGradient ? Colors.white : iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: hasGradient
                          ? Colors.white.withValues(alpha: 0.8)
                          : Theme.of(
                              context,
                            ).extension<ThemeColors>()?.unselectedLabel,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          color: hasGradient
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (errorMessage != null) ...[
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'Data gagal dimuat: $errorMessage',
                          child: Icon(
                            Icons.error_outline,
                            size: 18,
                            color: hasGradient
                                ? Colors.white
                                : AppColors.destructiveRedDark,
                          ),
                        ),
                      ],
                    ],
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
