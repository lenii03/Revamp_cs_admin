part of '../theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color appContainerBackground;
  final Color appTitleBar;
  final Color appContainerShadow;
  final Color selectedLabel;
  final Color unselectedLabel;
  final Color cursorColor;
  final Color micIcon;
  final Color hintColor;
  final Color settingsDialogLanguage;

  const ThemeColors({
    required this.appTitleBar,
    required this.appContainerBackground,
    required this.appContainerShadow,
    required this.selectedLabel,
    required this.unselectedLabel,
    required this.cursorColor,
    required this.micIcon,
    required this.hintColor,
    required this.settingsDialogLanguage,
  });

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? appTitleBar,
    Color? appContainerBackground,
    Color? appContainerShadow,
    Color? selectedLabel,
    Color? unselectedLabel,
    Color? cursorColor,
    Color? micIcon,
    Color? hintColor,
    Color? settingsDialogLanguage,
  }) {
    return ThemeColors(
      appContainerBackground:
          appContainerBackground ?? this.appContainerBackground,
      appTitleBar: appTitleBar ?? this.appTitleBar,
      appContainerShadow: appContainerShadow ?? this.appContainerShadow,
      selectedLabel: selectedLabel ?? this.selectedLabel,
      unselectedLabel: unselectedLabel ?? this.unselectedLabel,
      cursorColor: cursorColor ?? this.cursorColor,
      micIcon: micIcon ?? this.micIcon,
      hintColor: hintColor ?? this.hintColor,
      settingsDialogLanguage:
          settingsDialogLanguage ?? this.settingsDialogLanguage,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
      appContainerBackground: Color.lerp(
        appContainerBackground,
        other.appContainerBackground,
        t,
      )!,
      appTitleBar: Color.lerp(appTitleBar, other.appTitleBar, t)!,
      appContainerShadow: Color.lerp(
        appContainerShadow,
        other.appContainerShadow,
        t,
      )!,
      selectedLabel: Color.lerp(selectedLabel, other.selectedLabel, t)!,
      unselectedLabel: Color.lerp(unselectedLabel, other.unselectedLabel, t)!,
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t)!,
      micIcon: Color.lerp(micIcon, other.micIcon, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      settingsDialogLanguage: Color.lerp(
        settingsDialogLanguage,
        other.settingsDialogLanguage,
        t,
      )!,
    );
  }

  static get light => ThemeColors(
    appTitleBar: AppColors.white,
    appContainerBackground: AppColors.white,
    appContainerShadow: AppColors.grey.withValues(alpha: 0.5),
    selectedLabel: AppColors.darkestGrey,
    unselectedLabel: AppColors.darkestGrey.withValues(alpha: 0.7),
    cursorColor: AppColors.primary.withValues(alpha: 0.5),
    micIcon: AppColors.black,
    hintColor: AppColors.darkerGrey,
    settingsDialogLanguage: AppColors.white,
  );

  static get dark => ThemeColors(
    appTitleBar: AppColors.backgroundDarkest,
    appContainerBackground: AppColors.backgroundDark,
    appContainerShadow: AppColors.darkerGrey.withValues(alpha: 0.2),
    selectedLabel: AppColors.darkestGrey,
    unselectedLabel: AppColors.darkestGrey.withValues(alpha: 0.7),
    cursorColor: AppColors.primary,
    micIcon: AppColors.white,
    hintColor: AppColors.lighterGrey,
    settingsDialogLanguage: AppColors.lighterDark,
  );
}
