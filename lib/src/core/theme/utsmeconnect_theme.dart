import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_sizes.dart';

/// class to contain the properties
class UTSMEConnectThemeState {
  bool darkMode;
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
    this.darkMode = false,
    this.uiScale = UTSMEConnectSizes.kDefaultUiScale,
    this.primaryTextSize = UTSMEConnectSizes.kDefaultPrimaryTextSize,
  })  : // set the theme colors based on the mode
        primaryBackgroundColor = darkMode
            ? UTSMEConnectColors.kBackgroundPrimaryD
            : UTSMEConnectColors.kBackgroundPrimaryL,
        secondaryBackgroundColor = darkMode
            ? UTSMEConnectColors.kBackgroundSecondaryD
            : UTSMEConnectColors.kBackgroundSecondaryL,
        activeItemColor = darkMode
            ? UTSMEConnectColors.kActiveItemD
            : UTSMEConnectColors.kActiveItemL,
        inActiveItemColor = darkMode
            ? UTSMEConnectColors.kInActiveItemD
            : UTSMEConnectColors.kInActiveItemL,
        textColor = darkMode
            ? UTSMEConnectColors.kTextColorD
            : UTSMEConnectColors.kTextColorL,
        textFieldBorderColor = darkMode
            ? UTSMEConnectColors.kTextFieldBorderD
            : UTSMEConnectColors.kTextFieldBorderL,
        textFieldErrorBorderColor = darkMode
            ? UTSMEConnectColors.kTextFieldErrorBorderD
            : UTSMEConnectColors.kTextFieldErrorBorderL,
        minValueColor = darkMode
            ? UTSMEConnectColors.kMinValueD
            : UTSMEConnectColors.kMinValueL,
        maxValueColor = darkMode
            ? UTSMEConnectColors.kMaxValueD
            : UTSMEConnectColors.kMaxValueL;

  UTSMEConnectThemeState copyWith({
    required bool darkMode,
    required double uiScale,
    required double primaryTextSize,
  }) {
    return UTSMEConnectThemeState(
      darkMode: darkMode,
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
      darkMode: state.darkMode,
      uiScale: state.uiScale,
      primaryTextSize: state.primaryTextSize,
    );
  }

  // Dark mode switch
  void switchDarkMode() {
    state.darkMode = !state.darkMode;
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
