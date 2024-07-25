import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/features/shared/view/widgets/vertical_card.dart';
import 'package:utsmeconnect/src/features/temperature/controller/temperature_controller.dart';

class TemperatureScreen extends ConsumerStatefulWidget {
  const TemperatureScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TemperatureScreenState();
}

class _TemperatureScreenState extends ConsumerState<TemperatureScreen> {
  // Retrieve the controller
  late TemperatureState temperatureControllerState =
      ref.watch(temperatureControllerProvider);

  // Initialize the temperature values
  late double tireTemperature = 0;

  void periodicallyUpdateTemperatureData() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      double newTireTemperature = temperatureControllerState.tireTemperature;
      if (tireTemperature != newTireTemperature) {
        setState(() {
          tireTemperature = newTireTemperature;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    periodicallyUpdateTemperatureData();
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
            // Tire Temperature
            VerticalCard(
              screenWidth: screenWidth,
              cardHeight: 150,
              cardLabel: "Tire Temperature",
              cardWidget: Text(
                "${(tireTemperature).toInt()}°",
                style: const TextStyle(color: Colors.white70, fontSize: 70),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
