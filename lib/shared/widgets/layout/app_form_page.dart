import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/theme/app_spacing.dart';
import '../buttons/app_back_button.dart';

/// Page layout shared by Figma's form screens ("03 Mobile number",
/// "04 Enter the code", ...): back button at the top left, content below it,
/// and actions pinned to the bottom.
///
/// * When the keyboard opens, the [Scaffold] shrinks the page so the
///   [bottom] actions sit just above the keyboard.
/// * When the content is taller than the window (small phones, landscape,
///   large text), the whole page scrolls instead of overflowing.
/// * On tablets the content is centred and capped at
///   [AppSpacing.maxContentWidth].
class AppFormPage extends StatelessWidget {
  const AppFormPage({super.key, required this.body, required this.bottom});

  final Widget body;
  final Widget bottom;

  // Figma's 390×844 frame assumes iPhone insets of 47 px (top) and 34 px
  // (bottom). The back button's 44 px box starts at y = 48, so its 48 px tap
  // area starts at 46, which is 1 px *above* the inset. The title starts at
  // y = 107, 13 px below that tap area. The last bottom element ends 24 px
  // above the screen edge, 10 px into the bottom inset.
  static const double _figmaTop = 46;
  static const double _topInsetOverlap = 1;
  static const double _gapBelowBackButton = 13;
  static const double _figmaBottom = 24;
  static const double _bottomInsetOverlap = 10;

  /// Space between the 48 px tap area and the 44 px visible box on each side.
  static const double _tapAreaOutset = 2;

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.paddingOf(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Centres and caps the content by widening the side padding, so
          // text is measured at its real width.
          final availableWidth =
              constraints.maxWidth -
              insets.horizontal -
              2 * AppSpacing.screenEdge;
          final centring = math.max(
            0.0,
            (availableWidth - AppSpacing.maxContentWidth) / 2,
          );

          return CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    insets.left + centring,
                    math.max(_figmaTop, insets.top - _topInsetOverlap),
                    insets.right + centring,
                    math.max(_figmaBottom, insets.bottom - _bottomInsetOverlap),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: AppSpacing.backButtonInset - _tapAreaOutset,
                          ),
                          child: AppBackButton(),
                        ),
                      ),
                      const SizedBox(height: _gapBelowBackButton),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenEdge,
                        ),
                        child: body,
                      ),
                      // Minimum gap above the actions; the Spacer adds the
                      // rest when there is room.
                      const SizedBox(height: AppSpacing.screenEdge),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenEdge,
                        ),
                        child: bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
