import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_assets.dart';

/// One mint check mark plus text line from Figma "02 Welcome".
///
/// Figma: 20×20 icon, 10 px gap, Regular 15/21.8 white text that wraps.
class WelcomeHighlightRow extends StatelessWidget {
  const WelcomeHighlightRow({super.key, required this.text});

  final String text;

  /// Moves the icon down so it lines up with the first line of text, as in Figma.
  static const double _iconTopOffset = 1.5;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: _iconTopOffset),
          child: SvgPicture.asset(
            AppAssets.checkIcon,
            width: 20,
            height: 20,
            // Decorative: the text carries the meaning.
            excludeFromSemantics: true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppTextStyles.body)),
      ],
    );
  }
}
