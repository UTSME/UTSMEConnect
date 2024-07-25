import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';
import 'package:utsmeconnect/src/features/dashboard/controller/dashboard_controller.dart';
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
    double screenWidth = MediaQuery.sizeOf(context).width;
    //double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: UTSMEConnectColors.kBackgroundPrimary,
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
                arcBackgroundColor: Colors.white24,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: UTSMEConnectColors.kSelectedItem,
                backgroundColor: Colors.white24,
                backgroundWidth: 15,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(speed).toInt()}",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 50),
                    ),
                    const Text(
                      "KM/H",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
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
                          const TextStyle(color: Colors.white70, fontSize: 70),
                    ),
                    const TextSpan(
                      text: "mm",
                      style: TextStyle(color: Colors.white70, fontSize: 25),
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
