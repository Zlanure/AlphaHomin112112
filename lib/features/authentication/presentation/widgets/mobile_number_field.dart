import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../utils/indian_mobile_number.dart';

/// Figma "03 Mobile number" field: "Mobile number" label, then a 58 px box
/// with "+91", a thin divider and the number input.
///
/// Border colour: Figma's 28% white at rest, mint while focused, amber when
/// [errorText] is set (focus and error styles approved in Phase 2). The
/// screen owns [controller] and [focusNode] and disposes them.
class MobileNumberField extends StatelessWidget {
  const MobileNumberField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
    this.errorText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final errorText = this.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Mobile number', style: AppTextStyles.fieldLabel),
        const SizedBox(height: 8),
        // Rebuilds only the box (not the whole screen) when focus changes.
        ListenableBuilder(
          listenable: focusNode,
          builder: (context, child) {
            final borderColor = errorText != null
                ? AppColors.warning
                : focusNode.hasFocus
                ? AppColors.mint
                : AppColors.fieldBorder;

            return Container(
              constraints: const BoxConstraints(
                minHeight: AppSpacing.fieldHeight,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                border: Border.all(color: borderColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSpacing.fieldRadius),
                ),
              ),
              child: child,
            );
          },
          child: Row(
            children: [
              const Text('+91', style: AppTextStyles.countryCode),
              const SizedBox(width: 10),
              const SizedBox(
                width: 1,
                height: 24,
                child: ColoredBox(color: AppColors.divider),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: AppTextStyles.input,
                  cursorColor: AppColors.mint,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.telephoneNumberNational],
                  inputFormatters: const [IndianMobileNumberFormatter()],
                  decoration: InputDecoration.collapsed(
                    hintText: '98765 43210',
                    hintStyle: AppTextStyles.input.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  onChanged: onChanged,
                  onSubmitted: (_) => onSubmitted(),
                  // Touch screens don't close the keyboard on an outside tap
                  // by default; this makes them.
                  onTapOutside: (_) => focusNode.unfocus(),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 8),
          // liveRegion makes screen readers announce the message when it
          // appears.
          Semantics(
            liveRegion: true,
            child: Text(errorText, style: AppTextStyles.fieldError),
          ),
        ],
      ],
    );
  }
}
