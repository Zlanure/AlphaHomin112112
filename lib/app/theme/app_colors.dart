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
}
