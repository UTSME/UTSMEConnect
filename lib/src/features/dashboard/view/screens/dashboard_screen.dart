import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_paths.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';
import 'package:utsmeconnect/src/features/dashboard/controller/dashboard_controller.dart';
import 'package:utsmeconnect/src/features/settings/view/screens/settings_screen.dart';
import 'package:utsmeconnect/src/features/shared/view/widgets/vertical_card.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Retrieve the controller
  late DashboardState dashboardControllerState =
      ref.watch(dashboardControllerProvider);

  // Initialize the dashboard values
  late double speed = 0;
  late double suspension = 0;

  void periodicallyUpdateDashboardData() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      double newSpeed = dashboardControllerState.speed;
      double newSuspension = dashboardControllerState.suspension;
      if (speed != newSpeed || suspension != newSuspension) {
        setState(() {
          speed = newSpeed;
          suspension = newSuspension;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    periodicallyUpdateDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    // retrieve the theme state
    UTSMEConnectThemeState themeState =
        ref.watch(utsmeConnectThemeControllerProvider);

    double screenWidth = MediaQuery.sizeOf(context).width;
    //double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      // Appbar with UTSME Text logo and settings drawer
      appBar: AppBar(
        title: Image.asset(UTSMEConnectPaths.kLogoText, scale: 1.4),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.settings),
              iconSize: 30,
            ),
          ),
        ],
      ),
      endDrawer: const Drawer(child: SettingsScreen()),
      backgroundColor: themeState.primaryBackgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            // Speedometer
            VerticalCard(
              screenWidth: screenWidth,
              cardHeight: 200,
              cardLabel: "Speed",
              cardWidget: CircularPercentIndicator(
                radius: 75,
                percent: ((speed * 100) / UTSMEConnectValues.kMaxSpeed) / 100,
                lineWidth: 15,
                animation: true,
                animationDuration: 1200,
                animateFromLastPercent: true,
                curve: Curves.linearToEaseOut,
                arcType: ArcType.HALF,
                arcBackgroundColor: themeState.inActiveItemColor,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: themeState.activeItemColor,
                backgroundColor: themeState.inActiveItemColor,
                backgroundWidth: 15,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(speed).toInt()}",
                      style:
                          TextStyle(color: themeState.textColor, fontSize: 50),
                    ),
                    Text(
                      "KM/H",
                      style:
                          TextStyle(color: themeState.textColor, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            // Suspension
            VerticalCard(
              screenWidth: screenWidth,
              cardHeight: 150,
              cardLabel: "Suspension",
              cardWidget: Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 5),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "${(suspension).toInt()}",
                      style:
                          TextStyle(color: themeState.textColor, fontSize: 70),
                    ),
                    TextSpan(
                      text: "mm",
                      style:
                          TextStyle(color: themeState.textColor, fontSize: 25),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
