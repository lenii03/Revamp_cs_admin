import 'package:flutter/material.dart';
import '../../../../../core/theme/src/app_colors.dart';
import '../../../../../core/theme/theme.dart';

class PushNotificationTabWidget extends StatelessWidget {
  const PushNotificationTabWidget({super.key});

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
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final labelColor = Theme.of(
      context,
    ).extension<ThemeColors>()?.unselectedLabel;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: containerBg, // 👈 Dinamis
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: separatorColor), // 👈 Dinamis
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kirim Notifikasi Baru",
              style: TextStyle(
                color: textColor, // 👈 Dinamis
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            _buildLabel("Title", labelColor),
            const SizedBox(height: 8),
            _buildTextField(
              context,
              hint: "Masukkan judul notifikasi",
              isDark: isDark,
              textColor: textColor,
            ),

            const SizedBox(height: 20),

            _buildLabel("Sub Title", labelColor),
            const SizedBox(height: 8),
            _buildTextField(
              context,
              hint: "Masukkan sub judul notifikasi",
              maxLines: 3,
              isDark: isDark,
              textColor: textColor,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor, // 👈 Seragam Cyan
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color? color) => Text(
    text,
    style: TextStyle(color: color), // 👈 Dinamis
  );

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    int maxLines = 1,
    required bool isDark,
    required Color? textColor,
  }) {
    final fillColor = isDark
        ? const Color(0xFF1E1E2C)
        : AppColors.backgroundLight;
    final hintColor = isDark
        ? Colors.white.withValues(alpha: 0.3)
        : AppColors.secondaryTextColorLight;
    final borderColor = isDark ? Colors.transparent : AppColors.lighterGrey;

    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: textColor), // 👈 Dinamis
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: fillColor, // 👈 Dinamis
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
