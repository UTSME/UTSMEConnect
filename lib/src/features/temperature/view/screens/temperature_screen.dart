import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_paths.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';
import 'package:utsmeconnect/src/features/settings/view/screens/settings_screen.dart';
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
            // Tire Temperature
            VerticalCard(
              screenWidth: screenWidth,
              cardHeight: 150,
              cardLabel: "Tire Temperature",
              cardWidget: Text(
                "${(tireTemperature).toInt()}°",
                style: TextStyle(color: themeState.textColor, fontSize: 70),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
