import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/features/dashboard/controller/dashboard_controller.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late DashboardState dashboardControllerState =
      ref.watch(dashboardControllerProvider);
  late double speed = 100;

  void periodicallyUpdateDashboardData() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      double newSpeed = dashboardControllerState.speed;
      if (speed != newSpeed) {
        setState(() {
          speed = newSpeed;
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: screenWidth - 50,
                height: 200,
                decoration: BoxDecoration(
                  color: UTSMEConnectColors.kBackgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // we use "start" to have the label at the leftmost side
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Speed",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // We use Align to center the speedometer
                    Align(
                      child: CircularPercentIndicator(
                        radius: 75,
                        percent: ((speed * 100) / 150) / 100,
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
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 50),
                            ),
                            const Text(
                              "KM/H",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
