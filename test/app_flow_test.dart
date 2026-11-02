import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homingle/app/app.dart';
import 'package:homingle/features/authentication/presentation/screens/mobile_number_screen.dart';
import 'package:homingle/features/authentication/presentation/screens/verify_code_placeholder_screen.dart';
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
      expect(find.byType(MobileNumberScreen), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });
  }

  testWidgets('a valid number opens Enter the code with that number', (
    tester,
  ) async {
    await pumpPastSplash(tester);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '9876543210');
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();

    expect(find.byType(VerifyCodePlaceholderScreen), findsOneWidget);
    expect(find.textContaining('+91 98765 43210'), findsOneWidget);

    // Back returns to the number screen with the number still there.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(MobileNumberScreen), findsOneWidget);
    expect(find.text('98765 43210'), findsOneWidget);
  });
}
