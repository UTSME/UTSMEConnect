import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';

class HorizontalCardWithPercentage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // retrieve the theme state
    UTSMEConnectThemeState themeState =
        ref.watch(utsmeConnectThemeControllerProvider);

    double primaryTextSize = themeState.primaryTextSize;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: screenWidth - 50,
        height: 140,
        decoration: BoxDecoration(
          color: themeState.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(label,
                style: TextStyle(
                  color: themeState.textColor,
                  fontSize: primaryTextSize,
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
              progressColor: themeState.activeItemColor,
              backgroundColor: themeState.inActiveItemColor,
              backgroundWidth: 12,
              center: Text(
                "${value.toInt()}%",
                style: TextStyle(
                    color: themeState.textColor, fontSize: primaryTextSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
