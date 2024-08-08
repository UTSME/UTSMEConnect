import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_sizes.dart';

/// class to contain the properties
class UTSMEConnectThemeState {
  bool lightMode;
  double uiScale;
  double primaryTextSize;

  // theme colors
  Color primaryBackgroundColor;
  Color secondaryBackgroundColor;
  Color activeItemColor;
  Color inActiveItemColor;
  Color textColor;
  Color textFieldBorderColor;
  Color textFieldErrorBorderColor;
  Color minValueColor;
  Color maxValueColor;

  UTSMEConnectThemeState({
    this.lightMode = false,
    this.uiScale = UTSMEConnectSizes.kDefaultUiScale,
    this.primaryTextSize = UTSMEConnectSizes.kDefaultPrimaryTextSize,
  })  : // set the theme colors based on the mode
        primaryBackgroundColor = lightMode
            ? UTSMEConnectColors.kBackgroundPrimaryL
            : UTSMEConnectColors.kBackgroundPrimaryD,
        secondaryBackgroundColor = lightMode
            ? UTSMEConnectColors.kBackgroundSecondaryL
            : UTSMEConnectColors.kBackgroundSecondaryD,
        activeItemColor = lightMode
            ? UTSMEConnectColors.kActiveItemL
            : UTSMEConnectColors.kActiveItemD,
        inActiveItemColor = lightMode
            ? UTSMEConnectColors.kInActiveItemL
            : UTSMEConnectColors.kInActiveItemD,
        textColor = lightMode
            ? UTSMEConnectColors.kTextColorL
            : UTSMEConnectColors.kTextColorD,
        textFieldBorderColor = lightMode
            ? UTSMEConnectColors.kTextFieldBorderL
            : UTSMEConnectColors.kTextFieldBorderD,
        textFieldErrorBorderColor = lightMode
            ? UTSMEConnectColors.kTextFieldErrorBorderL
            : UTSMEConnectColors.kTextFieldErrorBorderD,
        minValueColor = lightMode
            ? UTSMEConnectColors.kMinValueL
            : UTSMEConnectColors.kMinValueD,
        maxValueColor = lightMode
            ? UTSMEConnectColors.kMaxValueL
            : UTSMEConnectColors.kMaxValueD;

  UTSMEConnectThemeState copyWith({
    required bool lightMode,
    required double uiScale,
    required double primaryTextSize,
  }) {
    return UTSMEConnectThemeState(
      lightMode: lightMode,
      uiScale: uiScale,
      primaryTextSize: primaryTextSize,
    );
  }
}

/// class to do operations on the properties
///
/// THIS CLASS IS FOR MUTATION OPERATIONS ONLY
/// TO ACCESS THE DATA, USE THE STATE CLASS ABOVE
class UTSMEConnectThemeController
    extends StateNotifier<UTSMEConnectThemeState> {
  UTSMEConnectThemeController(super.state);

  // Method to update the state after mutation
  void updateState() {
    state = state.copyWith(
      lightMode: state.lightMode,
      uiScale: state.uiScale,
      primaryTextSize: state.primaryTextSize,
    );
  }

  // Light mode switch
  void switchLightMode() {
    state.lightMode = !state.lightMode;
    updateState();
  }

  // Interface scaling methods
  void increaseUiScale() {
    if (state.uiScale < UTSMEConnectSizes.kMaxUiScale) {
      state.uiScale = state.uiScale += 0.1;
    }
    updateState();
  }

  void decreaseUiScale() {
    if (state.uiScale > UTSMEConnectSizes.kMinUiScale) {
      state.uiScale = state.uiScale -= 0.1;
    }
    updateState();
  }

  // Text scaling methods
  void setPrimaryTextSize(double newSize) {
    state.primaryTextSize = newSize;
    updateState();
  }

  void resetPrimaryTextSize() {
    state.primaryTextSize = UTSMEConnectSizes.kDefaultPrimaryTextSize;
    updateState();
  }
}

/// exposing the controller using Riverpod
final utsmeConnectThemeControllerProvider =
    StateNotifierProvider<UTSMEConnectThemeController, UTSMEConnectThemeState>(
        (ref) {
  return UTSMEConnectThemeController(UTSMEConnectThemeState());
});
