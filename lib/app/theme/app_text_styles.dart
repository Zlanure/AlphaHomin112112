import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Typography tokens from Figma. Every style uses Plus Jakarta Sans.
///
/// Figma gives line heights in pixels; Flutter's [TextStyle.height] is a
/// multiple of the font size, so each height is `figmaLineHeight / fontSize`.
/// [TextLeadingDistribution.even] splits the extra line space equally above
/// and below the glyphs, the way Figma does, so text sits at the same
/// position as in the design.
abstract final class AppTextStyles {
  static const String fontFamily = 'PlusJakartaSans';

  /// "Homingle" on the splash screen: ExtraBold 40/58, tracking -1.2.
  static const TextStyle splashWordmark = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w800,
    height: 58 / 40,
    letterSpacing: -1.2,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.ink,
  );

  /// Small "Homingle" at the top of a screen: ExtraBold 22/31.9, tracking -0.4.
  static const TextStyle wordmark = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w800,
    height: 31.9 / 22,
    letterSpacing: -0.4,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Large screen headline: ExtraBold 31/35.7, tracking -0.6.
  static const TextStyle displayHeadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 31,
    fontWeight: FontWeight.w800,
    height: 35.7 / 31,
    letterSpacing: -0.6,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Body copy: Regular 15/21.8.
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 21.8 / 15,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Label inside the mint pill button: Bold 16/23.2.
  static const TextStyle buttonLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 23.2 / 16,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.ink,
  );

  /// Text-only link button: Bold 15/21.8.
  static const TextStyle linkLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 21.8 / 15,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.mint,
  );
}
