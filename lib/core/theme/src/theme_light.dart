part of '../theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.black),
        bodyLarge: TextStyle(color: AppColors.black),
        bodySmall: TextStyle(color: AppColors.black),
        labelMedium: TextStyle(color: AppColors.black),
        labelLarge: TextStyle(color: AppColors.black),
        labelSmall: TextStyle(color: AppColors.black),
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      onSurface: AppColors.black  ,
    ),
    extensions: <ThemeExtension<dynamic>>[
      ThemeColors.light,
      ThemeTextStyles.light,
      ThemePluto.light,
    ],
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.lightGrey),
      titleTextStyle: headline1.copyWith(
        color: AppColors.grey,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      titleTextStyle: headline1.copyWith(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      contentTextStyle: headline1.copyWith(
        color: AppColors.black,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.white,
      textStyle: headline1.copyWith(
        color: AppColors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.black
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.darkerGrey,fontWeight: FontWeight.w400),
      errorStyle: const TextStyle(
        fontSize: 11.0,
      ),
      iconColor: AppColors.darkerGrey,
      labelStyle: const TextStyle(
          color: AppColors.darkerGrey
      ),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(width: 0.5, color: AppColors.backgroundDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(width: 0.5, color: AppColors.lighterGrey),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(width: 0.5, color: AppColors.lighterGrey.withValues(alpha: 0.4)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(width: 1, color: Colors.redAccent),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: AppColors.foregroundLight,
      textColor: AppColors.black,
      collapsedTextColor: AppColors.black,
      iconColor: AppColors.black,
      collapsedIconColor: AppColors.black.withValues(alpha: 0.5)
    ),
    scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStateProperty.all(6),
        thumbColor: MaterialStateProperty.all(AppColors.primary.withValues(alpha: 0.5)),
        radius: const Radius.circular(10),
        thumbVisibility: MaterialStateProperty.all(true),
        minThumbLength: 50),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.primary,
            elevation: 0,
            shadowColor: Colors.transparent,
            visualDensity: VisualDensity.compact,
            minimumSize: const Size(100,40),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.primary, width: 1),
        minimumSize: const Size(100,40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      foregroundColor: AppColors.primary
    ),
    ),

    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.white,
      headerForegroundColor: AppColors.white,
      dayOverlayColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.5)),
      yearStyle: const TextStyle(color: AppColors.primary),
      yearOverlayColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.5)),
      headerBackgroundColor: AppColors.primary,

      surfaceTintColor: AppColors.white,
      dividerColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
      checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          side: BorderSide(color: AppColors.black.withValues(alpha:0.2),width: 2)
      ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: AppColors.white,fontSize: 11),
      verticalOffset: 10
    )


  );
}
