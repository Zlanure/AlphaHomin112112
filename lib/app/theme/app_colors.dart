import 'package:flutter/painting.dart';

/// Colour tokens taken from the Homingle Figma file.
///
/// The file defines no Figma variables, so these values are read directly
/// from the layers that use them.
abstract final class AppColors {
  /// Dark green-black used for screen backgrounds and text on mint.
  static const Color ink = Color(0xFF11211E);

  /// Brand mint used for the splash, primary buttons, links and icons.
  static const Color mint = Color(0xFF19E6C4);

  /// Neutral fill shown where a photo has not been supplied.
  static const Color photoPlaceholder = Color(0xFFD3DBD5);

  static const Color white = Color(0xFFFFFFFF);

  /// Secondary text on dark backgrounds (subtitles, hints, captions).
  static const Color textMuted = Color(0xFF9DB8B4);

  /// Text field background: white at 8%.
  static const Color fieldFill = Color(0x14FFFFFF);

  /// Text field border: white at 28%.
  static const Color fieldBorder = Color(0x47FFFFFF);

  /// Thin separators, such as the line after "+91": white at 12%.
  static const Color divider = Color(0x1FFFFFFF);

  /// Amber warning colour from Figma "24 Verification failed"; used for
  /// validation messages (approved for Phase 2).
  static const Color warning = Color(0xFFFFC46B);
}
