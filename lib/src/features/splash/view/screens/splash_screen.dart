import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/navigation/utsmeconnect_router.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';
import 'package:utsmeconnect/src/features/splash/view/widgets/rectangular_container.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Timer(
          const Duration(seconds: 3),
          // Use "goNamed" for splash screens with bottom navigation bars
          () => UTSMEConnectRouter.router
              .goNamed(UTSMEConnectRoutes.dashboard.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    // retrieve the theme state
    UTSMEConnectThemeState themeState =
        ref.watch(utsmeConnectThemeControllerProvider);

    return Scaffold(
        backgroundColor: themeState.primaryBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: RectangularContainer(
                value: "UTS:ME Connect",
                borderColor: themeState.secondaryBackgroundColor,
                rectangleColor: themeState.primaryBackgroundColor,
              ),
            ),
          ),
        ));
  }
}
