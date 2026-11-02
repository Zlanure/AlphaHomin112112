import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homingle/features/authentication/presentation/utils/indian_mobile_number.dart';

void main() {
  group('IndianMobileNumber', () {
    test('accepts 10 digits starting with 6–9 only', () {
      expect(IndianMobileNumber.isValid('9876543210'), isTrue);
      expect(IndianMobileNumber.isValid('6000000000'), isTrue);
      expect(IndianMobileNumber.isValid('5876543210'), isFalse);
      expect(IndianMobileNumber.isValid('987654321'), isFalse);
      expect(IndianMobileNumber.isValid(''), isFalse);
    });

    test('formats like the Figma hint', () {
      expect(IndianMobileNumber.format('98765'), '98765');
      expect(IndianMobileNumber.format('987654'), '98765 4');
      expect(IndianMobileNumber.format('9876543210'), '98765 43210');
    });

    test('reads numbers from the Android phone-number picker', () {
      expect(IndianMobileNumber.fromPhoneHint('+919876543210'), '9876543210');
      expect(IndianMobileNumber.fromPhoneHint('09876543210'), '9876543210');
      expect(IndianMobileNumber.fromPhoneHint('9876543210'), '9876543210');
      expect(IndianMobileNumber.fromPhoneHint('+14155550123'), isNull);
    });
  });

  group('IndianMobileNumberFormatter', () {
    const formatter = IndianMobileNumberFormatter();

    TextEditingValue type(String text) => formatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      ),
    );

    test('keeps digits only, caps at 10 and adds the space', () {
      expect(type('98765a43-210').text, '98765 43210');
      expect(type('9876543210999').text, '98765 43210');
      expect(type('+91 98765').text, '91987 65');
    });

    test('puts the cursor after the last typed digit', () {
      final value = type('987654');
      expect(value.text, '98765 4');
      expect(value.selection.baseOffset, 7);
    });
  });
}
