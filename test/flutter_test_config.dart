import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs before every test file in `test/`.
///
/// Widget tests normally draw all text in a placeholder font whose glyphs are
/// wide squares, which makes text wrap far more than on a device. Loading the
/// real Plus Jakarta Sans files makes layout and geometry checks meaningful.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final loader = FontLoader('PlusJakartaSans');
  for (final weight in ['Regular', 'Bold', 'ExtraBold']) {
    loader.addFont(rootBundle.load('assets/fonts/PlusJakartaSans-$weight.ttf'));
  }
  await loader.load();

  await testMain();
}
