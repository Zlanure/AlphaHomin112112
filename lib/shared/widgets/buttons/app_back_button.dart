import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_assets.dart';

/// The Figma back button: a white 22 px chevron in a 44×44 box with 12 px
/// corners.
///
/// The visible box stays 44 px, but `MaterialTapTargetSize.padded` grows the
/// tappable area to 48 px. By default it does what the system back button
/// does ([Navigator.maybePop]).
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      style: IconButton.styleFrom(
        foregroundColor: AppColors.white,
        fixedSize: const Size.square(AppSpacing.backButtonSize),
        minimumSize: const Size.square(AppSpacing.backButtonSize),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.padded,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.backButtonRadius),
          ),
        ),
      ),
      icon: SvgPicture.asset(
        AppAssets.backIcon,
        width: 22,
        height: 22,
        excludeFromSemantics: true,
      ),
    );
  }
}
