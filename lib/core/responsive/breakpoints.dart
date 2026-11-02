/// Window-width breakpoints shared by every screen (CLAUDE.md §8).
///
/// Layouts depend on the space available, never on a device name.
abstract final class Breakpoints {
  /// Widths from this value up are "medium" (large phones in landscape,
  /// small tablets, unfolded foldables).
  static const double medium = 600;

  /// Widths from this value up are "expanded" (tablets, desktop windows).
  static const double expanded = 840;

  /// Below this height a landscape phone has too little room for a stacked
  /// layout, so screens may switch to two columns.
  static const double shortHeight = 500;
}
