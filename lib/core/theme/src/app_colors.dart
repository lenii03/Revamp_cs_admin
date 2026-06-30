import 'package:flutter/material.dart';

class AppColors {
  // ==========================================
  // 1. BACKGROUNDS (Diupdate ke Navy/Teal Gelap)
  // ==========================================
  static const Color backgroundDark = Color(0xFF081017);
  static const Color systemBackgroundDark = Color(0xFF081017);
  static const Color systemBackgroundLight = Color(0xFFF8FAFC);

  static const Color cardDark = Color(0xFF101924);
  static const Color systemGroupedBackgroundDark = Color(0xFF101924);
  static const Color systemGroupedBackgroundLight = Color(0xFFFFFFFF);

  // ==========================================
  // 2. WARNA PRIMER & BAWAAN LAMA (Agar tidak error di Login dll)
  // ==========================================
  static const Color primaryColor = Color(0xFF06B6D4);
  static const Color primaryLight = Color(0xFF06B6D4);
  static const Color primaryDark = Color(0xFF22D3EE);

  static const Color accentGreen = Color(0xFF10B981);
  static const Color successGreen = Color(0xFF2ECA8B);

  static const Color systemGreenLight = Color(0xFF10B981);
  static const Color systemGreenDark = Color(0xFF34D399);
  static const Color systemOrangeLight = Color(0xFFF59E0B);
  static const Color systemOrangeDark = Color(0xFFFBBF24);
  // ==========================================
  // 3. VIBRANT GRADIENTS (Kontras Tinggi)
  // ==========================================
  static const LinearGradient tealGradient = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFF007A8C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFFB388FF), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [Color(0xFFFFB74D), Color(0xFFE65100)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [Color(0xFFFF80AB), Color(0xFFC51162)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient mainBackgroundGradient = LinearGradient(
    colors: [Color(0xFF13253A), Color(0xFF081017)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // ==========================================
  // 4. STATUS COLORS (Baru - Untuk Badge)
  // ==========================================
  static const Color statusActive = Color(0xFF10B981);
  static const Color statusPending = Color(0xFFFBBF24);
  static const Color statusInactive = Color(0xFF475569);

  static Color activeBackground = const Color(
    0xFF10B981,
  ).withValues(alpha: 0.15);
  static Color pendingBackground = const Color(
    0xFFFBBF24,
  ).withValues(alpha: 0.15);
  static Color inactiveBackground = const Color(
    0xFF475569,
  ).withValues(alpha: 0.15);

  // ==========================================
  // 5. TEXT & SEPARATOR
  // ==========================================
  static const Color textWhite = Color(0xFFF8FAFC);
  static const Color textColorLight = Color(0xFF0F172A);
  static const Color textColorDark = Color(0xFFF8FAFC);

  static const Color textGrey = Color(0xFF8BA3B5);
  static const Color secondaryTextColorLight = Color(0xFF475569);
  static const Color secondaryTextColorDark = Color(0xFF8BA3B5);

  static const Color separatorLight = Color(0xFFE2E8F0);
  static const Color separatorDark = Color(0xFF1D2A3A); // Garis lebih halus

  // ==========================================
  // 6. DESTRUCTIVE / ERROR
  // ==========================================
  static const Color errorRed = Color(0xFFF6465D);
  static const Color destructiveRedLight = Color(0xFFEF4444);
  static const Color destructiveRedDark = Color(0xFFF87171);

  // ==========================================
  // --- KOMPATIBILITAS KODE LAMA ---
  // (Variabel ini dicari oleh tema lama agar tidak merah)
  // ==========================================
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF8BA3B5); // Alias untuk textGrey
  static const Color lightGrey = Color(0xFF8BA3B5);
  static const Color lighterGrey = Color(0xFFE2E8F0);
  static const Color darkerGrey = Color(0xFF475569);
  static const Color darkestGrey = Color(0xFF0F172A);
  static const Color primary = Color(0xFF06B6D4); // Alias untuk primaryColor
  static const Color foregroundLight = Color(0xFFFFFFFF);
  static const Color foregroundDark = Color(0xFF101924);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDarkest = Color(0xFF081017);
  static const Color lighterDark = Color(0xFF101924);
}
