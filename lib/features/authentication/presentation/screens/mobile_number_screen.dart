import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/buttons/app_button.dart';
import '../../../../shared/widgets/layout/app_form_page.dart';
import '../../../../shared/widgets/typography/app_screen_header.dart';
import '../utils/indian_mobile_number.dart';
import '../widgets/mobile_number_field.dart';

/// Figma "03 Mobile number": used both to sign up and to log in.
///
/// Autofill:
/// * Android: on opening, Google's phone-number picker offers the numbers on
///   the SIM cards (via `smart_auth`); picking one fills the field.
/// * iOS: the keyboard suggests the user's own number natively, through the
///   field's `AutofillHints.telephoneNumberNational`.
///
/// No code is actually sent; this phase is UI only. A valid number opens
/// "Enter the code" with the number in the route.
class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  static const String invalidNumberMessage =
      'Enter a valid 10-digit mobile number';

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // After the first frame, so the screen is on-screen before the system
    // picker or keyboard appears.
    WidgetsBinding.instance.addPostFrameCallback((_) => _prefillAndFocus());
  }

  Future<void> _prefillAndFocus() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final result = await SmartAuth.instance.requestPhoneNumberHint();
      if (!mounted) return;
      final hint = result.data;
      final digits = hint == null
          ? null
          : IndianMobileNumber.fromPhoneHint(hint);
      if (digits != null) {
        final text = IndianMobileNumber.format(digits);
        _controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    }
    // Opens the keyboard whether or not a number was picked.
    if (mounted) _focusNode.requestFocus();
  }

  void _onChanged(String _) {
    // Clear the warning as soon as the user starts correcting the number.
    if (_errorText != null) setState(() => _errorText = null);
  }

  void _sendCode() {
    final digits = IndianMobileNumber.digitsOf(_controller.text);
    if (!IndianMobileNumber.isValid(digits)) {
      setState(() => _errorText = MobileNumberScreen.invalidNumberMessage);
      _focusNode.requestFocus();
      return;
    }
    _focusNode.unfocus();
    context.push(AppRoutes.verifyCodeLocation(digits));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFormPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppScreenHeader(
            title: 'Enter your mobile number',
            subtitle: 'We will text you a 6-digit code to confirm it is you.',
          ),
          const SizedBox(height: 20),
          MobileNumberField(
            controller: _controller,
            focusNode: _focusNode,
            errorText: _errorText,
            onChanged: _onChanged,
            onSubmitted: _sendCode,
          ),
        ],
      ),
      bottom: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton.primary(label: 'Send code', onPressed: _sendCode),
          const SizedBox(height: 12),
          const Text(
            'By continuing you agree to the Terms of Service and Privacy '
            'Policy.',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
