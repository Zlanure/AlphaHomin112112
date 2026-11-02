import 'package:flutter/services.dart';

/// Rules for the 10-digit Indian mobile numbers typed after the fixed "+91".
abstract final class IndianMobileNumber {
  static const int length = 10;

  /// Indian mobile numbers have 10 digits and start with 6, 7, 8 or 9.
  static final RegExp _valid = RegExp(r'^[6-9]\d{9}$');
  static final RegExp _nonDigit = RegExp(r'\D');

  /// Removes everything except digits, e.g. "98765 43210" → "9876543210".
  static String digitsOf(String text) => text.replaceAll(_nonDigit, '');

  static bool isValid(String digits) => _valid.hasMatch(digits);

  /// Shows up to 10 digits the way Figma's hint does: "98765 43210".
  static String format(String digits) => digits.length > 5
      ? '${digits.substring(0, 5)} ${digits.substring(5)}'
      : digits;

  /// Turns a number from the Android phone-number picker into 10 local
  /// digits. Accepts "+919876543210", "09876543210" or "9876543210"; returns
  /// null for anything that is not a valid Indian mobile number.
  static String? fromPhoneHint(String hint) {
    var digits = digitsOf(hint);
    if (digits.length == 12 && digits.startsWith('91')) {
      digits = digits.substring(2);
    } else if (digits.length == 11 && digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    return isValid(digits) ? digits : null;
  }
}

/// Keeps only digits, caps them at 10 and inserts the space after the fifth,
/// so typing or pasting always shows "98765 43210".
class IndianMobileNumberFormatter extends TextInputFormatter {
  const IndianMobileNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = IndianMobileNumber.digitsOf(newValue.text);
    final capped = digits.length > IndianMobileNumber.length
        ? digits.substring(0, IndianMobileNumber.length)
        : digits;
    final formatted = IndianMobileNumber.format(capped);

    // Keep the cursor after the same digit it was after before formatting.
    final cursor = newValue.selection.end.clamp(0, newValue.text.length);
    final digitsBeforeCursor = IndianMobileNumber.digitsOf(
      newValue.text.substring(0, cursor),
    ).length.clamp(0, capped.length);
    final offset = digitsBeforeCursor > 5
        ? digitsBeforeCursor + 1
        : digitsBeforeCursor;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
