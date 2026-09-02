import 'package:flutter/material.dart';

import '../../core/theme/src/app_colors.dart';
import '../../core/theme/theme.dart';

enum AppNoticeType { info, warning, success, error }

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Continue',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final secondaryColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;
    final accentColor = isDestructive
        ? AppColors.destructiveRedDark
        : const Color(0xFFFBBF24);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 380,
        padding: const EdgeInsets.fromLTRB(28, 26, 28, 24),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.32),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDestructive
                    ? Icons.delete_outline_rounded
                    : Icons.help_outline_rounded,
                color: accentColor,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryColor,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(cancelLabel),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDestructive
                          ? AppColors.destructiveRedDark
                          : AppColors.primaryColor,
                      foregroundColor: AppColors.textWhite,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      confirmLabel,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppNoticeDialog extends StatelessWidget {
  const AppNoticeDialog({
    super.key,
    required this.title,
    required this.message,
    this.type = AppNoticeType.info,
    this.buttonLabel = 'OK',
  });

  final String title;
  final String message;
  final AppNoticeType type;
  final String buttonLabel;

  ({IconData icon, Color color}) get _appearance {
    return switch (type) {
      AppNoticeType.warning => (
          icon: Icons.warning_amber_rounded,
          color: const Color(0xFFFBBF24),
        ),
      AppNoticeType.success => (
          icon: Icons.check_circle_outline_rounded,
          color: AppColors.successGreen,
        ),
      AppNoticeType.error => (
          icon: Icons.error_outline_rounded,
          color: AppColors.destructiveRedDark,
        ),
      AppNoticeType.info => (
          icon: Icons.info_outline_rounded,
          color: AppColors.primaryDark,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final appearance = _appearance;
    final containerColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.appContainerBackground;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final secondaryColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 380,
        padding: const EdgeInsets.fromLTRB(28, 26, 28, 24),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.32),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: appearance.color.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                appearance.icon,
                color: appearance.color,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondaryColor,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.textWhite,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
