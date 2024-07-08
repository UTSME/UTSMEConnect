import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:utsmeconnect/src/features/power/controller/power_controller.dart';

class PowerScreen extends ConsumerWidget {
  const PowerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //the controller for the power screen
    final powerControllerState = ref.watch(powerControllerProvider);

    double screenWidth = MediaQuery.sizeOf(context).width;
    //double screenHeight = MediaQuery.sizeOf(context).height;

    ValueNotifier<double> powerChargeNotifier =
        ValueNotifier(powerControllerState.charge);

    return Scaffold(
      backgroundColor: UTSMEConnectColors.kBackgroundPrimary,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
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
                    const Text("CURRENT CHARGE:  ",
                        style: TextStyle(color: Colors.white70, fontSize: 20)),
                    SimpleCircularProgressBar(
                      size: 70,
                      maxValue: 100,
                      valueNotifier: powerChargeNotifier,
                      progressColors: const [UTSMEConnectColors.kSelectedItem],
                      progressStrokeWidth: 12,
                      mergeMode: true,
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
