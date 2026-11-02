import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homingle/app/theme/app_spacing.dart';
import 'package:homingle/app/theme/app_theme.dart';
import 'package:homingle/features/onboarding/presentation/screens/welcome_screen.dart';

/// Representative windows from CLAUDE.md §8 (logical px).
const _viewports = <Size>[
  Size(320, 640),
  Size(390, 844),
  Size(430, 932),
  Size(600, 960),
  Size(840, 900),
  Size(1024, 1366),
  Size(1366, 1024),
  Size(844, 390), // phone in landscape
];

Future<void> _pumpWelcome(
  WidgetTester tester, {
  required Size size,
  double textScale = 1,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      home: MediaQuery.withClampedTextScaling(
        minScaleFactor: textScale,
        maxScaleFactor: textScale,
        child: const WelcomeScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  for (final size in _viewports) {
    for (final textScale in [1.0, 2.0]) {
      testWidgets(
        'lays out without overflow at ${size.width.toInt()}×${size.height.toInt()}, '
        'text ×$textScale',
        (tester) async {
          await _pumpWelcome(tester, size: size, textScale: textScale);

          // A RenderFlex overflow is reported as an exception.
          expect(tester.takeException(), isNull);

          // Both buttons are reachable (scrolling into view if needed).
          for (final label in ['Get started', 'I already have an account']) {
            await tester.ensureVisible(find.text(label));
            await tester.pumpAndSettle();
            expect(find.text(label).hitTestable(), findsOneWidget);
          }
        },
      );
    }
  }

  testWidgets('matches the Figma geometry at the 390×844 reference', (
    tester,
  ) async {
    await _pumpWelcome(tester, size: const Size(390, 844));

    final photo = tester.getRect(find.byType(AspectRatio));
    expect(photo.left, AppSpacing.screenEdge);
    expect(photo.width, 342);
    expect(photo.height, closeTo(250, 0.01));
    // Figma 109.9; Flutter rounds the 31.9 px wordmark line up to 32.
    expect(photo.top, closeTo(109.9, 0.2));

    final primary = tester.getRect(find.byType(FilledButton));
    expect(primary.top, closeTo(714, 0.01));
    expect(primary.width, 342);
    expect(primary.height, AppSpacing.primaryButtonHeight);

    // Figma's link box is 776–820; ours is 2 px taller on each side.
    final link = tester.getRect(find.byType(TextButton));
    expect(link.top, closeTo(774, 0.01));
    expect(link.bottom, closeTo(822, 0.01));
  });

  testWidgets('uses two columns on wide landscape windows', (tester) async {
    await _pumpWelcome(tester, size: const Size(1366, 1024));

    final photo = tester.getRect(find.byType(AspectRatio));
    final headline = tester.getRect(
      find.text('Find a flatmate you can actually live with.'),
    );
    expect(headline.left, greaterThan(photo.right));
  });

  testWidgets('headline is announced as a heading', (tester) async {
    final handle = tester.ensureSemantics();
    await _pumpWelcome(tester, size: const Size(390, 844));

    expect(
      tester.getSemantics(
        find.text('Find a flatmate you can actually live with.'),
      ),
      matchesSemantics(
        label: 'Find a flatmate you can actually live with.',
        isHeader: true,
      ),
    );
    handle.dispose();
  });
}
