import 'dart:async';

import 'package:flutter/material.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/core/navigation/utsmeconnect_router.dart';
import 'package:utsmeconnect/src/features/splash/view/widgets/rectangular_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Timer(
          const Duration(seconds: 3),
          // Use "goNamed" for splash screens with bottom navigation bars
          () =>
              UTSMEConnectRouter.router.goNamed(UTSMEConnectRoutes.power.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: UTSMEConnectColors.kBackgroundPrimary,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: RectangularContainer(
                value: "UTS:ME Connect",
                borderColor: UTSMEConnectColors.kBackgroundSecondary,
                rectangleColor: UTSMEConnectColors.kBackgroundPrimary,
              ),
            ),
          ),
        ));
  }
}
