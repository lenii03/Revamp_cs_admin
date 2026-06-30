part of '../theme.dart';

ThemeData darkTheme() {
  return ThemeData(
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.white),
      bodyLarge: TextStyle(color: AppColors.white),
      bodySmall: TextStyle(color: AppColors.white),
      labelMedium: TextStyle(color: AppColors.white),
      labelLarge: TextStyle(color: AppColors.white),
      labelSmall: TextStyle(color: AppColors.white),
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      onSurface: AppColors.white,
    ),

    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.dark,
      ThemeTextStyles.dark,
      ThemePluto.dark,
    ],
    appBarTheme: AppBarTheme(
      color: AppColors.lighterDark,
      iconTheme: const IconThemeData(color: AppColors.lightGrey),
      titleTextStyle: headline1.copyWith(
        color: AppColors.grey,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.backgroundDark,
      surfaceTintColor: AppColors.backgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      titleTextStyle: headline1.copyWith(
        color: AppColors.darkestGrey,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      contentTextStyle: headline1.copyWith(color: AppColors.darkestGrey),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.lighterDark,
      textStyle: headline1.copyWith(color: AppColors.lighterGrey),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: AppColors.white.withValues(alpha: 0.4),
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(fontSize: 11.0, color: Colors.redAccent),

      iconColor: AppColors.white,
      labelStyle: const TextStyle(color: AppColors.white),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(width: 1, color: AppColors.foregroundDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(width: 1, color: AppColors.foregroundDark),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.foregroundDark.withValues(alpha: 0.5),
        ),
      ),
    ),
    visualDensity: VisualDensity.compact,
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: AppColors.backgroundDarkest,
      textColor: AppColors.white,
      collapsedTextColor: AppColors.white,
      iconColor: AppColors.white,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: MaterialStateProperty.all(6),
      thumbColor: MaterialStateProperty.all(
        AppColors.primary.withValues(alpha: 0.5),
      ),
      radius: const Radius.circular(10),
      thumbVisibility: MaterialStateProperty.all(true),
      minThumbLength: 50,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.foregroundDark,
        foregroundColor: AppColors.white.withValues(alpha: 0.8),
        elevation: 0,
        shadowColor: Colors.transparent,
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primary, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        foregroundColor: AppColors.white.withValues(alpha: 0.8),
        visualDensity: VisualDensity.compact,
        minimumSize: const Size(100, 40),
      ),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.backgroundDark,
      headerForegroundColor: AppColors.white,
      dayForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      rangePickerHeaderForegroundColor: AppColors.white,
      todayForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      yearForegroundColor: const WidgetStatePropertyAll(AppColors.white),
      dayOverlayColor: WidgetStatePropertyAll(
        AppColors.primary.withValues(alpha: 0.5),
      ),
      yearStyle: const TextStyle(color: AppColors.primary),
      yearOverlayColor: WidgetStatePropertyAll(
        AppColors.primary.withValues(alpha: 0.5),
      ),
      headerBackgroundColor: AppColors.primary,

      surfaceTintColor: AppColors.backgroundDark,
      dividerColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),

    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: BorderSide(color: AppColors.white.withValues(alpha: 0.1), width: 2),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: AppColors.black, fontSize: 11),
      verticalOffset: 10,
    ),
  );
}
