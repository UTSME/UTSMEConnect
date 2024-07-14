import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/features/power/controller/power_controller.dart';

class PowerScreen extends ConsumerStatefulWidget {
  const PowerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PowerScreenState();
}

class _PowerScreenState extends ConsumerState<PowerScreen> {
  late PowerState powerControllerState = ref.watch(powerControllerProvider);
  late double charge = 100;

  void periodicallyUpdateChargeData() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      double newCharge = powerControllerState.charge;
      if (charge != newCharge) {
        setState(() {
          charge = newCharge;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    periodicallyUpdateChargeData();
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
            // Current Charge
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: screenWidth - 50,
                height: 140,
                decoration: BoxDecoration(
                  color: UTSMEConnectColors.kBackgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Current Charge",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    CircularPercentIndicator(
                      radius: 48,
                      percent: charge / 100.0,
                      lineWidth: 12,
                      animation: true,
                      animationDuration: 1200,
                      animateFromLastPercent: true,
                      curve: Curves.linearToEaseOut,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: UTSMEConnectColors.kSelectedItem,
                      backgroundColor: Colors.white24,
                      backgroundWidth: 12,
                      center: Text(
                        "${charge.toInt()}%",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 20),
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
