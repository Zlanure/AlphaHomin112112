import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../utils/indian_mobile_number.dart';

/// TEMPORARY stand-in for Figma "04 Enter the code", which arrives in Phase 3.
///
/// It exists so "Send code" goes somewhere and shows that the number arrives.
/// Phase 3 replaces it with the real screen.
class VerifyCodePlaceholderScreen extends StatelessWidget {
  const VerifyCodePlaceholderScreen({super.key, required this.phoneDigits});

  /// The 10 digits entered on the previous screen, e.g. "9876543210".
  final String phoneDigits;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenEdge),
            child: Text(
              'Enter the code – Phase 3\n'
              'Code for +91 ${IndianMobileNumber.format(phoneDigits)}',
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
