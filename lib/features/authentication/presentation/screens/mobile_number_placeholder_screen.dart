import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';

/// TEMPORARY stand-in for Figma "03 Mobile number", which arrives in Phase 2.
///
/// It exists only so the welcome screen's buttons go somewhere. Phase 2
/// replaces it with the real screen.
class MobileNumberPlaceholderScreen extends StatelessWidget {
  const MobileNumberPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.screenEdge),
            child: Text(
              'Mobile number – Phase 2',
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
