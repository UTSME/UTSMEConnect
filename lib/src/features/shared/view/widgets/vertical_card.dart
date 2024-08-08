import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';

class VerticalCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // retrieve the theme state
    UTSMEConnectThemeState themeState =
        ref.watch(utsmeConnectThemeControllerProvider);

    double primaryTextSize = themeState.primaryTextSize;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: screenWidth - 50,
        height: cardHeight,
        decoration: BoxDecoration(
          color: themeState.secondaryBackgroundColor,
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
                style: TextStyle(
                  color: themeState.textColor,
                  fontSize: primaryTextSize,
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
