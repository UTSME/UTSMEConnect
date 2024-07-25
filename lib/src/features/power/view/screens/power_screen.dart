import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';
import 'package:utsmeconnect/src/features/power/controller/power_controller.dart';
import 'package:utsmeconnect/src/features/shared/view/widgets/vertical_card.dart';

class PowerScreen extends ConsumerStatefulWidget {
  const PowerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PowerScreenState();
}

class _PowerScreenState extends ConsumerState<PowerScreen> {
  late PowerState powerControllerState = ref.watch(powerControllerProvider);
  late double charge = 100;
  late double minVoltage = 0;
  late double maxVoltage = 0;

  void periodicallyUpdateChargeData() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      double newCharge = powerControllerState.charge;
      double newMinVoltage = powerControllerState.minVoltage;
      double newMaxVoltage = powerControllerState.maxVoltage;
      if (charge != newCharge) {
        setState(() {
          charge = newCharge;
          minVoltage = newMinVoltage;
          maxVoltage = newMaxVoltage;
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

            //Voltage Range
            VerticalCard(
              screenWidth: screenWidth,
              cardHeight: 150,
              cardLabel: "Voltage Range",
              cardWidget: Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Column(
                  children: [
                    //Spacer
                    Container(height: 10),

                    // Minimum Voltage
                    LinearPercentIndicator(
                      percent: ((minVoltage * 100) /
                              UTSMEConnectValues.kMinVoltage) /
                          100,
                      lineHeight: 30,
                      barRadius: const Radius.circular(10),
                      animation: true,
                      animationDuration: 2000,
                      animateFromLastPercent: true,
                      curve: Curves.linearToEaseOut,
                      backgroundColor: Colors.white24,
                      progressColor: UTSMEConnectColors.kMinValue,
                      center: Text(
                        minVoltage.toInt().toString(),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 20),
                      ),
                    ),

                    //Spacer
                    Container(height: 15),

                    // Maximum Voltage
                    LinearPercentIndicator(
                      percent: ((maxVoltage * 100) /
                              UTSMEConnectValues.kMaxVoltage) /
                          100,
                      lineHeight: 30,
                      barRadius: const Radius.circular(10),
                      animation: true,
                      animationDuration: 2000,
                      animateFromLastPercent: true,
                      curve: Curves.linearToEaseOut,
                      backgroundColor: Colors.white24,
                      progressColor: UTSMEConnectColors.kMaxValue,
                      center: Text(
                        maxVoltage.toInt().toString(),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 20),
                      ),
                    ),

                    //Spacer
                    Container(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
