import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';

enum _AppButtonVariant { primary, text }

/// The two full-width button styles used in Figma.
///
/// * [AppButton.primary]: mint pill, 56 px tall, dark Bold 16 label
///   (for example "Get started").
/// * [AppButton.text]: label only, mint Bold 15 text
///   (for example "I already have an account").
///
/// Both have a minimum height, not a fixed one, so they grow with large text
/// instead of clipping the label.
class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
  }) : _variant = _AppButtonVariant.primary;

  const AppButton.text({
    super.key,
    required this.label,
    required this.onPressed,
  }) : _variant = _AppButtonVariant.text;

  final String label;
  final VoidCallback onPressed;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final labelText = Text(label, textAlign: TextAlign.center);

    return switch (_variant) {
      _AppButtonVariant.primary => FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.mint,
          foregroundColor: AppColors.ink,
          textStyle: AppTextStyles.buttonLabel,
          minimumSize: const Size.fromHeight(AppSpacing.primaryButtonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenEdge,
          ),
          shape: const StadiumBorder(),
        ),
        child: labelText,
      ),
      _AppButtonVariant.text => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mint,
          textStyle: AppTextStyles.linkLabel,
          minimumSize: const Size.fromHeight(AppSpacing.linkButtonHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenEdge,
          ),
          shape: const StadiumBorder(),
        ),
        child: labelText,
      ),
    };
  }
}
