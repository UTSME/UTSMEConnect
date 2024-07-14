import 'package:flutter/material.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    super.key,
    required this.screenWidth,
    required this.cardHeight,
    required this.cardLabel,
    required this.cardWidget,
  });

  final double screenWidth;
  final double cardHeight;
  final String cardLabel;
  final Widget cardWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: screenWidth - 50,
        height: cardHeight,
        decoration: BoxDecoration(
          color: UTSMEConnectColors.kBackgroundSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // we use "start" to have the label at the leftmost side
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                cardLabel,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // We use Align to center the card widget
            Align(
              child: cardWidget,
            ),
          ],
        ),
      ),
    );
  }
}
