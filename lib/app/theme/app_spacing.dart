/// Spacing, size and corner-radius tokens that repeat across Figma frames.
abstract final class AppSpacing {
  /// Left/right margin used by every Figma frame (390 px wide, 24 px each side).
  static const double screenEdge = 24;

  /// Widest a single-column layout grows on tablets, so the phone design is
  /// not stretched edge to edge.
  static const double maxContentWidth = 480;

  /// Widest a two-column layout grows on large or landscape screens.
  static const double maxTwoPaneWidth = 1040;

  static const double photoRadius = 24;

  /// Height of the mint pill button; its radius is half of this.
  static const double primaryButtonHeight = 56;

  /// Figma draws text links 44 px tall. They get a 48 px tap area to meet the
  /// Android minimum, while the label stays where Figma places it.
  static const double linkButtonHeight = 48;

  /// Back button: Figma draws a 44×44 box with 12 px corners, inset 8 px from
  /// the left edge. It gets a 48 px tap area like the text link.
  static const double backButtonSize = 44;
  static const double backButtonRadius = 12;
  static const double backButtonInset = 8;

  static const double fieldHeight = 58;
  static const double fieldRadius = 14;
}
