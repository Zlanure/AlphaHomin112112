import 'package:flutter/material.dart';

import '../../../app/theme/app_text_styles.dart';

/// Title and optional subtitle at the top of a screen, as in Figma
/// "03 Mobile number", "04 Enter the code" and "09 About you".
///
/// Title: ExtraBold 28/32.2 white. Subtitle: Regular 15/21.8 muted, 10 px
/// below. The title is announced as a heading by screen readers.
class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: AppTextStyles.screenTitle),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Text(subtitle, style: AppTextStyles.bodyMuted),
        ],
      ],
    );
  }
}
