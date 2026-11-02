import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root widget. It owns the [GoRouter], so each app instance (including each
/// widget test) gets a fresh router that is disposed with it.
class HomingleApp extends StatefulWidget {
  const HomingleApp({super.key});

  @override
  State<HomingleApp> createState() => _HomingleAppState();
}

class _HomingleAppState extends State<HomingleApp> {
  late final GoRouter _router = createAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Homingle',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: _router,
    );
  }
}
