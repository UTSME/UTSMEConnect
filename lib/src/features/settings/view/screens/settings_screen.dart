import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_sizes.dart';
import 'package:utsmeconnect/src/core/theme/utsmeconnect_theme.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // retrieve the theme state and controller
    UTSMEConnectThemeState themeState =
        ref.watch(utsmeConnectThemeControllerProvider);
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
            // Enable Light Mode
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
                    Text(
                      "Enable Light Mode",
                      style: TextStyle(
                        color: themeController.getTextColor(),
                        fontSize: primaryTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 85,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          value: themeState.lightMode,
                          activeTrackColor:
                              themeController.getActiveItemColor(),
                          inactiveTrackColor:
                              themeController.getInActiveItemColor(),
                          inactiveThumbColor: Colors.white,
                          onChanged: (value) =>
                              themeController.switchLightMode(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Change Primary Text Size
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: screenWidth - 50,
                height: 180,
                decoration: BoxDecoration(
                  color: themeController.getBackgroundSecondaryColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top line has the label and font size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Primary Text Size",
                          style: TextStyle(
                            color: themeController.getTextColor(),
                            fontSize: primaryTextSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            themeController
                                .getPrimaryTextSize()
                                .toInt()
                                .toString(),
                            style: TextStyle(
                              color: themeController.getTextColor(),
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Second line has the text size slider
                    Slider(
                      min: UTSMEConnectSizes.kMinPrimaryTextSize,
                      max: UTSMEConnectSizes.kMaxPrimaryTextSize,
                      activeColor: themeController.getActiveItemColor(),
                      inactiveColor: themeController.getInActiveItemColor(),
                      value: themeController.getPrimaryTextSize(),
                      onChanged: (value) =>
                          themeController.setPrimaryTextSize(value),
                    ),

                    // Bottom line has the reset text size to default button
                    ElevatedButton(
                      //color: themeController.getInActiveItemColor(),
                      //shape: BorderRadiusDirectional.circular(radius),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            themeController.getInActiveItemColor()),
                        overlayColor: WidgetStatePropertyAll(
                            themeController.getInActiveItemColor()),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () => themeController.resetPrimaryTextSize(),
                      child: Text(
                        "Reset to Default Size",
                        style: TextStyle(
                          color: themeController.getTextColor(),
                          fontSize: primaryTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Spacer
                    Container(height: 12),
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
