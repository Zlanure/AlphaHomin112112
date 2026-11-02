import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homingle/app/app.dart';
import 'package:homingle/features/authentication/presentation/screens/mobile_number_placeholder_screen.dart';
import 'package:homingle/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:homingle/features/splash/presentation/screens/splash_screen.dart';

void main() {
  setUp(() {
    // The Figma reference viewport.
    final view =
        TestWidgetsFlutterBinding.instance.platformDispatcher.views.first;
    view.physicalSize = const Size(390, 844);
    view.devicePixelRatio = 1;
  });

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.views.first.reset();
  });

  Future<void> pumpPastSplash(WidgetTester tester) async {
    await tester.pumpWidget(const HomingleApp());
    await tester.pump(SplashScreen.displayDuration);
    await tester.pumpAndSettle();
  }

  testWidgets('splash shows the wordmark, then replaces itself with welcome', (
    tester,
  ) async {
    await tester.pumpWidget(const HomingleApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Homingle'), findsOneWidget);

    // Not yet: the splash must stay for the full duration.
    await tester.pump(
      SplashScreen.displayDuration - const Duration(milliseconds: 1),
    );
    expect(find.byType(WelcomeScreen), findsNothing);

    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpAndSettle();

    expect(find.byType(WelcomeScreen), findsOneWidget);
    expect(find.byType(SplashScreen), findsNothing);
  });

  testWidgets('back on welcome does not return to the splash', (tester) async {
    await pumpPastSplash(tester);

    final navigator = tester.state<NavigatorState>(
      find.byType(Navigator).first,
    );
    expect(navigator.canPop(), isFalse);
  });

  for (final label in ['Get started', 'I already have an account']) {
    testWidgets('"$label" opens Mobile number and back returns to welcome', (
      tester,
    ) async {
      await pumpPastSplash(tester);

      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      expect(find.byType(MobileNumberPlaceholderScreen), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });
  }
}
