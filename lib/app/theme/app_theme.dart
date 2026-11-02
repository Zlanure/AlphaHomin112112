import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Builds the app's [ThemeData] from the Figma tokens.
ThemeData buildAppTheme() {
  const colorScheme = ColorScheme.dark(
    primary: AppColors.mint,
    onPrimary: AppColors.ink,
    surface: AppColors.ink,
    onSurface: AppColors.white,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.ink,
    fontFamily: AppTextStyles.fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.ink,
      foregroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
