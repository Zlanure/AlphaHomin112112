import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/screens/mobile_number_screen.dart';
import '../../features/authentication/presentation/screens/verify_code_placeholder_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

/// Every route path in one place, so screens never hard-code strings.
abstract final class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String mobileNumber = '/mobile-number';
  static const String verifyCode = '/verify-code';

  /// Query parameter carrying the 10-digit number to "Enter the code".
  static const String phoneParam = 'phone';

  /// "/verify-code?phone=9876543210"
  static String verifyCodeLocation(String phoneDigits) => Uri(
    path: verifyCode,
    queryParameters: {phoneParam: phoneDigits},
  ).toString();
}

/// Creates the app's router. [HomingleApp] owns the instance and disposes it.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (_, _) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.mobileNumber,
        builder: (_, _) => const MobileNumberScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyCode,
        builder: (_, state) => VerifyCodePlaceholderScreen(
          phoneDigits: state.uri.queryParameters[AppRoutes.phoneParam] ?? '',
        ),
      ),
    ],
  );
}
