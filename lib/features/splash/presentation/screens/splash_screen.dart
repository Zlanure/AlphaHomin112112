import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Figma "01 Splash": full-screen mint with the centred "Homingle" wordmark.
///
/// Waits [displayDuration], then replaces itself with the welcome screen so
/// the back button can never return here.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  /// Figma does not specify a duration; 1.5 s was agreed for Phase 1.
  static const Duration displayDuration = Duration(milliseconds: 1500);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(SplashScreen.displayDuration, _goToWelcome);
  }

  void _goToWelcome() {
    if (!mounted) return;
    context.go(AppRoutes.welcome);
  }

  @override
  void dispose() {
    // Stops the timer if the screen is removed before it fires.
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Dark status/navigation bar icons on the mint background.
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.mint,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: const Scaffold(
        backgroundColor: AppColors.mint,
        body: Center(
          child: Text(
            'Homingle',
            style: AppTextStyles.splashWordmark,
            // The wordmark is a logo, so it keeps its Figma size; screen
            // readers still announce "Homingle".
            textScaler: TextScaler.noScaling,
          ),
        ),
      ),
    );
  }
}
