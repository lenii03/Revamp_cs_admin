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

  static get light => ThemePluto(
    gridBackgroundColor: AppColors.darkerGrey,
    rowColor: AppColors.white,
    gridBorderColor: AppColors.darkerGrey,
    borderColor: AppColors.darkerGrey,
    menuBackgroundColor: AppColors.white,
    inactivatedBorderColor: AppColors.darkerGrey,
    activatedColor: AppColors.primary.withValues(alpha: 0.5),
    activatedBorderColor: Colors.transparent,
    iconColor: AppColors.backgroundDark,
    cellTextStyle: const TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
  );

  static get dark => const ThemePluto(
    gridBackgroundColor: AppColors.lighterDark,
    rowColor: AppColors.foregroundDark,
    gridBorderColor: AppColors.lighterDark,
    borderColor: AppColors.lighterDark,
    menuBackgroundColor: AppColors.foregroundDark,
    inactivatedBorderColor: AppColors.lighterDark,
    activatedColor: AppColors.primary,
    activatedBorderColor: AppColors.primary,
    iconColor: AppColors.white,
    cellTextStyle: TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  );
}
