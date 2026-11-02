import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Typography tokens from Figma. Every style uses Plus Jakarta Sans.
///
/// Figma gives line heights in pixels; Flutter's [TextStyle.height] is a
/// multiple of the font size, so each height is `figmaLineHeight / fontSize`.
/// [TextLeadingDistribution.even] splits the extra line space equally above
/// and below the glyphs, the way Figma does, so text sits at the same
/// position as in the design.
///
/// Every style sets [TextStyle.letterSpacing], 0 where Figma has none.
/// Otherwise the Material theme's default text styles add 0.1–0.5 px of
/// spacing, which changes where lines wrap.
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
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Body copy in the secondary colour, e.g. a screen subtitle.
  static const TextStyle bodyMuted = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 21.8 / 15,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textMuted,
  );

  /// Screen title under the back button: ExtraBold 28/32.2, tracking -0.6.
  static const TextStyle screenTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 32.2 / 28,
    letterSpacing: -0.6,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Label above a text field: Bold 13/18.9.
  static const TextStyle fieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 18.9 / 13,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Fixed "+91" prefix inside the phone field: ExtraBold 17/24.7.
  static const TextStyle countryCode = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w800,
    height: 24.7 / 17,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Text typed into a field: Regular 17/21.4. Figma shows only the hint, in
  /// [AppColors.textMuted]; typed text uses white.
  static const TextStyle input = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 21.4 / 17,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.white,
  );

  /// Validation message under a field. Figma has no error style; this uses
  /// the field-label size and the Figma warning colour (approved in Phase 2).
  static const TextStyle fieldError = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 18.9 / 13,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.warning,
  );

  /// Small print, such as the Terms line: Regular 12/16.8, muted.
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16.8 / 12,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.textMuted,
  );

  /// Label inside the mint pill button: Bold 16/23.2.
  static const TextStyle buttonLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 23.2 / 16,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.ink,
  );

  /// Text-only link button: Bold 15/21.8.
  static const TextStyle linkLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 21.8 / 15,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
    color: AppColors.mint,
  );
}
