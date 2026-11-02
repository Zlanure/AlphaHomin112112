import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/responsive/breakpoints.dart';
import '../../../../shared/widgets/buttons/app_button.dart';
import '../widgets/welcome_highlight_row.dart';

/// Figma "02 Welcome".
///
/// Phones get the Figma layout as a single column. Tablets keep that column,
/// centred and width-capped. Wide or short landscape windows switch to two
/// columns. The page scrolls whenever its content is taller than the window,
/// so nothing overflows on small screens or with large text.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const List<String> _highlights = [
    'Listers and everyone who contacts you are verified through DigiLocker',
    'No brokers and no brokerage',
    'Matched on how you really live',
  ];

  // Figma's 390×844 frame assumes iPhone insets of 47 px (top) and 34 px
  // (bottom). The wordmark sits 55 px from the top, which is 8 px below the
  // status bar. The link label sits 24 px above the bottom edge; with its
  // 48 px tap area that is 22 px, or 12 px into the 34 px inset. These values
  // reproduce Figma exactly on that phone and adapt on others.
  static const double _figmaTop = 55;
  static const double _gapBelowStatusBar = 8;
  static const double _figmaBottom = 22;
  static const double _bottomInsetOverlap = 12;

  void _openMobileNumber(BuildContext context) {
    context.push(AppRoutes.mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.paddingOf(context);

    final buttons = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton.primary(
          label: 'Get started',
          onPressed: () => _openMobileNumber(context),
        ),
        // Figma has a 6 px gap; the link's extra 2 px tap area on each side
        // takes up the rest.
        const SizedBox(height: 4),
        AppButton.text(
          label: 'I already have an account',
          onPressed: () => _openMobileNumber(context),
        ),
      ],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Light status/navigation bar icons on the dark background.
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.ink,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;
            final useTwoPane =
                isLandscape &&
                (constraints.maxWidth >= Breakpoints.expanded ||
                    constraints.maxHeight < Breakpoints.shortHeight);

            // Centres the content and caps its width by widening the side
            // padding, so text is measured at its real width.
            final maxWidth = useTwoPane
                ? AppSpacing.maxTwoPaneWidth
                : AppSpacing.maxContentWidth;
            final availableWidth =
                constraints.maxWidth -
                insets.horizontal -
                2 * AppSpacing.screenEdge;
            final centring = math.max(0.0, (availableWidth - maxWidth) / 2);

            final padding = EdgeInsets.fromLTRB(
              insets.left + AppSpacing.screenEdge + centring,
              math.max(_figmaTop, insets.top + _gapBelowStatusBar),
              insets.right + AppSpacing.screenEdge + centring,
              math.max(_figmaBottom, insets.bottom - _bottomInsetOverlap),
            );

            return CustomScrollView(
              slivers: [
                // Fills the window when the content is short (so the buttons
                // stay at the bottom) and scrolls when it is taller. The
                // padding sits inside so it is part of that height.
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: padding,
                    child: useTwoPane
                        ? _TwoPaneLayout(
                            highlights: _highlights,
                            buttons: buttons,
                          )
                        : _SingleColumnLayout(
                            highlights: _highlights,
                            buttons: buttons,
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// The Figma layout: content from the top, buttons pinned to the bottom.
class _SingleColumnLayout extends StatelessWidget {
  const _SingleColumnLayout({required this.highlights, required this.buttons});

  final List<String> highlights;
  final Widget buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Wordmark(),
        const SizedBox(height: 23),
        const _PhotoPlaceholder(),
        const SizedBox(height: 20),
        const _Headline(),
        const SizedBox(height: 17),
        _HighlightList(highlights: highlights),
        // Minimum gap above the buttons on short screens; the Spacer adds the
        // rest (about 140 px in total on the 390×844 Figma frame).
        const SizedBox(height: AppSpacing.screenEdge),
        const Spacer(),
        buttons,
      ],
    );
  }
}

/// Wide or short landscape windows: photo on the left, text and buttons on the
/// right, both centred vertically under the wordmark.
class _TwoPaneLayout extends StatelessWidget {
  const _TwoPaneLayout({required this.highlights, required this.buttons});

  final List<String> highlights;
  final Widget buttons;

  static const double _paneGap = 48;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Wordmark(),
        const SizedBox(height: 23),
        const Spacer(),
        Row(
          children: [
            const Expanded(child: _PhotoPlaceholder()),
            const SizedBox(width: _paneGap),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _Headline(),
                  const SizedBox(height: 17),
                  _HighlightList(highlights: highlights),
                  const SizedBox(height: 32),
                  buttons,
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark();

  @override
  Widget build(BuildContext context) {
    // A logo, so it keeps its Figma size even with large text enabled.
    return const Text(
      'Homingle',
      style: AppTextStyles.wordmark,
      textScaler: TextScaler.noScaling,
    );
  }
}

/// Figma layer "Photo 7a66b8ee": a 342×250 grey block with 24 px corners and
/// no image, kept exactly as designed. It scales with the column width while
/// keeping its proportions.
class _PhotoPlaceholder extends StatelessWidget {
  const _PhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 342 / 250,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.photoPlaceholder,
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.photoRadius),
          ),
        ),
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: const Text(
        'Find a flatmate you can actually live with.',
        style: AppTextStyles.displayHeadline,
      ),
    );
  }
}

class _HighlightList extends StatelessWidget {
  const _HighlightList({required this.highlights});

  final List<String> highlights;

  /// Gap between rows; puts each row within 1 px of its Figma position.
  static const double _rowGap = 9;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < highlights.length; i++) ...[
          if (i > 0) const SizedBox(height: _rowGap),
          WelcomeHighlightRow(text: highlights[i]),
        ],
      ],
    );
  }
}
