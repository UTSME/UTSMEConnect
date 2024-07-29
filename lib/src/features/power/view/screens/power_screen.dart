import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';
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
    // retrieve the theme controller
    UTSMEConnectThemeController themeController =
        ref.watch(utsmeConnectThemeControllerProvider.notifier);

    double screenWidth = MediaQuery.sizeOf(context).width;
    //double screenHeight = MediaQuery.sizeOf(context).height;
    double primaryTextSize = themeController.getPrimaryTextSize();

    return Scaffold(
      backgroundColor: themeController.getBackgroundPrimaryColor(),
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
                  color: themeController.getBackgroundSecondaryColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Current Charge",
                        style: TextStyle(
                          color: themeController.getTextColor(),
                          fontSize: primaryTextSize,
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
                      progressColor: themeController.getActiveItemColor(),
                      backgroundColor: themeController.getInActiveItemColor(),
                      backgroundWidth: 12,
                      center: Text(
                        "${charge.toInt()}%",
                        style: TextStyle(
                            color: themeController.getTextColor(),
                            fontSize: primaryTextSize),
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
                      backgroundColor: themeController.getInActiveItemColor(),
                      progressColor: themeController.getMinValueColor(),
                      center: Text(
                        minVoltage.toInt().toString(),
                        style: TextStyle(
                            color: themeController.getTextColor(),
                            fontSize: primaryTextSize),
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
                      backgroundColor: themeController.getInActiveItemColor(),
                      progressColor: themeController.getMaxValueColor(),
                      center: Text(
                        maxVoltage.toInt().toString(),
                        style: TextStyle(
                            color: themeController.getTextColor(),
                            fontSize: primaryTextSize),
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
