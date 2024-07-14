import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';

class HorizontalCardWithPercentage extends StatelessWidget {
  const HorizontalCardWithPercentage({
    super.key,
    required this.screenWidth,
    required this.label,
    required this.value,
  });

  final double screenWidth;
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            Text(label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            CircularPercentIndicator(
              radius: 48,
              percent: value / 100.0,
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
                "${value.toInt()}%",
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
