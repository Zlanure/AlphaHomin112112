import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homingle/app/theme/app_colors.dart';
import 'package:homingle/app/theme/app_spacing.dart';
import 'package:homingle/app/theme/app_theme.dart';
import 'package:homingle/features/authentication/presentation/screens/mobile_number_screen.dart';

/// Channel used by `smart_auth` for Android's phone-number picker.
const _phoneHintChannel =
    'dev.flutter.pigeon.smart_auth.SmartAuthApi.requestPhoneNumberHint';

const _viewports = <Size>[
  Size(320, 640),
  Size(390, 844),
  Size(430, 932),
  Size(600, 960),
  Size(840, 900),
  Size(1024, 1366),
  Size(1366, 1024),
  Size(844, 390),
];

Future<void> _pumpScreen(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  double textScale = 1,
  EdgeInsets viewInsets = EdgeInsets.zero,
  String? pickedPhoneNumber,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  _mockPhoneHint(tester, number: pickedPhoneNumber);
  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
            viewInsets: viewInsets,
          ),
          child: const MobileNumberScreen(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Color _fieldBorderColor(WidgetTester tester) {
  final box = tester.widget<Container>(
    find.ancestor(of: find.text('+91'), matching: find.byType(Container)).first,
  );
  final decoration = box.decoration! as BoxDecoration;
  return (decoration.border! as Border).top.color;
}

/// Replies to the phone-number picker as if the user picked [number], or
/// closed the picker when [number] is null.
void _mockPhoneHint(WidgetTester tester, {String? number}) {
  final messenger = tester.binding.defaultBinaryMessenger;
  messenger.setMockMessageHandler(
    _phoneHintChannel,
    (_) async => const StandardMessageCodec().encodeMessage(
      number != null
          ? <Object?>[number]
          : <Object?>['canceled', 'Picker closed', null],
    ),
  );
  addTearDown(() => messenger.setMockMessageHandler(_phoneHintChannel, null));
}

String _fieldText(WidgetTester tester) =>
    tester.widget<TextField>(find.byType(TextField)).controller!.text;

void main() {
  testWidgets('focuses the field on open with the Figma resting style first', (
    tester,
  ) async {
    await _pumpScreen(tester);

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.focusNode!.hasFocus, isTrue);
    expect(_fieldBorderColor(tester), AppColors.mint);

    // Tapping elsewhere closes the keyboard and restores the Figma border.
    await tester.tapAt(const Offset(195, 500));
    await tester.pumpAndSettle();
    expect(field.focusNode!.hasFocus, isFalse);
    expect(_fieldBorderColor(tester), AppColors.fieldBorder);
  });

  testWidgets('fills the number picked in the Android phone-number picker', (
    tester,
  ) async {
    await _pumpScreen(tester, pickedPhoneNumber: '+919876543210');

    expect(_fieldText(tester), '98765 43210');
    // The keyboard still opens after picking.
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.focusNode!.hasFocus, isTrue);
  });

  testWidgets('an invalid number shows the amber warning until edited', (
    tester,
  ) async {
    await _pumpScreen(tester);

    await tester.enterText(find.byType(TextField), '12345');
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();

    expect(find.text(MobileNumberScreen.invalidNumberMessage), findsOneWidget);
    expect(_fieldBorderColor(tester), AppColors.warning);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.pump();
    expect(find.text(MobileNumberScreen.invalidNumberMessage), findsNothing);
  });

  testWidgets('matches the Figma geometry at the 390×844 reference', (
    tester,
  ) async {
    tester.view.padding = const FakeViewPadding(top: 47, bottom: 34);
    await _pumpScreen(tester);
    // Close the keyboard focus so nothing differs from the Figma frame.
    await tester.tapAt(const Offset(195, 500));
    await tester.pumpAndSettle();

    // The visible 44 px box sits exactly where Figma puts it; the 48 px tap
    // area extends 2 px around it.
    final back = tester.getRect(find.byTooltip('Back'));
    expect(back.topLeft, const Offset(8, 48));
    expect(back.size, const Size.square(AppSpacing.backButtonSize));

    expect(
      tester.getTopLeft(find.text('Enter your mobile number')).dy,
      closeTo(107, 0.5),
    );
    final field = tester.getRect(
      find
          .ancestor(of: find.text('+91'), matching: find.byType(Container))
          .first,
    );
    expect(field.top, closeTo(240.5, 1));
    expect(field.width, 342);
    expect(field.height, AppSpacing.fieldHeight);

    final button = tester.getRect(find.byType(FilledButton));
    expect(button.top, closeTo(718.4, 0.5));
  });

  testWidgets('Send code stays visible above the keyboard', (tester) async {
    await _pumpScreen(tester, viewInsets: const EdgeInsets.only(bottom: 336));

    final button = tester.getRect(find.byType(FilledButton));
    expect(button.bottom, lessThanOrEqualTo(844 - 336));
  });

  for (final size in _viewports) {
    for (final textScale in [1.0, 2.0]) {
      testWidgets('lays out without overflow at ${size.width.toInt()}×'
          '${size.height.toInt()}, text ×$textScale', (tester) async {
        await _pumpScreen(tester, size: size, textScale: textScale);
        expect(tester.takeException(), isNull);

        await tester.ensureVisible(find.text('Send code'));
        await tester.pumpAndSettle();
        expect(find.text('Send code').hitTestable(), findsOneWidget);
      });
    }
  }

  testWidgets('title is a heading and the error is announced', (tester) async {
    final handle = tester.ensureSemantics();
    await _pumpScreen(tester);

    expect(
      tester.getSemantics(find.text('Enter your mobile number')),
      matchesSemantics(label: 'Enter your mobile number', isHeader: true),
    );

    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    expect(
      tester.getSemantics(find.text(MobileNumberScreen.invalidNumberMessage)),
      matchesSemantics(
        label: MobileNumberScreen.invalidNumberMessage,
        isLiveRegion: true,
      ),
    );
    handle.dispose();
  });
}
