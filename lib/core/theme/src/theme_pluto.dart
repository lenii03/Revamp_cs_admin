part of '../theme.dart';

class ThemePluto extends ThemeExtension<ThemePluto> {
  final Color gridBackgroundColor;
  final Color rowColor;
  final Color gridBorderColor;
  final Color borderColor;
  final Color menuBackgroundColor;
  final Color inactivatedBorderColor;
  final Color activatedColor;
  final Color activatedBorderColor;
  final Color iconColor;
  final TextStyle cellTextStyle;

  const ThemePluto({
    required this.gridBackgroundColor,
    required this.rowColor,
    required this.gridBorderColor,
    required this.borderColor,
    required this.menuBackgroundColor,
    required this.inactivatedBorderColor,
    required this.activatedColor,
    required this.activatedBorderColor,
    required this.iconColor,
    required this.cellTextStyle,
  });

  @override
  ThemeExtension<ThemePluto> copyWith({
    Color? gridBackgroundColor,
    Color? rowColor,
    Color? gridBorderColor,
    Color? borderColor,
    Color? menuBackgroundColor,
    Color? inactivatedBorderColor,
    Color? activatedColor,
    Color? activatedBorderColor,
    Color? iconColor,
    TextStyle? cellTextStyle,
  }) {
    return ThemePluto(
      gridBackgroundColor: gridBackgroundColor ?? this.gridBackgroundColor,
      rowColor: rowColor ?? this.rowColor,
      gridBorderColor: gridBorderColor ?? this.gridBorderColor,
      borderColor: borderColor ?? this.borderColor,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      inactivatedBorderColor:
          inactivatedBorderColor ?? this.inactivatedBorderColor,
      activatedColor: activatedColor ?? this.activatedColor,
      activatedBorderColor: activatedBorderColor ?? this.activatedBorderColor,
      iconColor: iconColor ?? this.iconColor,
      cellTextStyle: cellTextStyle ?? this.cellTextStyle,
    );
  }

  @override
  ThemeExtension<ThemePluto> lerp(ThemeExtension<ThemePluto>? other, double t) {
    if (other is! ThemePluto) {
      return this;
    }

    return ThemePluto(
      gridBackgroundColor: Color.lerp(
        gridBackgroundColor,
        other.gridBackgroundColor,
        t,
      )!,
      rowColor: Color.lerp(rowColor, other.rowColor, t)!,
      gridBorderColor: Color.lerp(gridBorderColor, other.gridBorderColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      menuBackgroundColor: Color.lerp(
        menuBackgroundColor,
        other.menuBackgroundColor,
        t,
      )!,
      inactivatedBorderColor: Color.lerp(
        inactivatedBorderColor,
        other.inactivatedBorderColor,
        t,
      )!,
      activatedColor: Color.lerp(activatedColor, other.activatedColor, t)!,
      activatedBorderColor: Color.lerp(
        activatedBorderColor,
        other.activatedBorderColor,
        t,
      )!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      cellTextStyle: TextStyle.lerp(cellTextStyle, other.cellTextStyle, t)!,
    );
  }

  static ThemePluto get light => ThemePluto(
    gridBackgroundColor: const Color(0xFFF8F9FA),
    rowColor: AppColors.white,
    gridBorderColor: AppColors.separatorLight,
    borderColor: AppColors.separatorLight,
    menuBackgroundColor: AppColors.white,
    inactivatedBorderColor: AppColors.separatorLight,
    activatedColor: AppColors.primary.withValues(alpha: 0.1),
    activatedBorderColor: Colors.transparent,
    iconColor: AppColors.black,
    cellTextStyle: const TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
  );

  static ThemePluto get dark => ThemePluto(
    gridBackgroundColor: AppColors.systemGroupedBackgroundDark,
    rowColor: AppColors.systemGroupedBackgroundDark,
    gridBorderColor: AppColors.separatorDark,
    borderColor: AppColors.separatorDark,
    menuBackgroundColor: AppColors.systemBackgroundDark,
    inactivatedBorderColor: AppColors.separatorDark,
    activatedColor: AppColors.primaryColor.withValues(alpha: 0.2),
    activatedBorderColor: Colors.transparent,
    iconColor: AppColors.white,
    cellTextStyle: const TextStyle(
      color: AppColors.textColorDark,
      fontSize: 13,
    ),
  );
}
