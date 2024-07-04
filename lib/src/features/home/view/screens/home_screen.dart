import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screen_width = MediaQuery.sizeOf(context).width;
    double screen_height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: UTSMEConnectColors.kBackgroundPrimary,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: screen_width - 50,
                height: 140,
                decoration: BoxDecoration(
                  color: UTSMEConnectColors.kBackgroundSecondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("CURRENT CHARGE:  ",
                        style: TextStyle(color: Colors.white70, fontSize: 20)),
                    SimpleCircularProgressBar(
                      size: 70,
                      progressColors: [UTSMEConnectColors.kSelectedItem],
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
