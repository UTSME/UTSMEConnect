import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_colors.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_sizes.dart';

/// class to contain the properties
class UTSMEConnectThemeState {
  bool lightMode;
  double uiScale;
  double primaryTextSize;

  UTSMEConnectThemeState({
    required this.lightMode,
    required this.uiScale,
    required this.primaryTextSize,
  });

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

  // Colors getters
  Color getBackgroundPrimaryColor() {
    return state.lightMode
        ? UTSMEConnectColors.kBackgroundPrimaryL
        : UTSMEConnectColors.kBackgroundPrimaryD;
  }

  Color getBackgroundSecondaryColor() {
    return state.lightMode
        ? UTSMEConnectColors.kBackgroundSecondaryL
        : UTSMEConnectColors.kBackgroundSecondaryD;
  }

  Color getActiveItemColor() {
    return state.lightMode
        ? UTSMEConnectColors.kActiveItemL
        : UTSMEConnectColors.kActiveItemD;
  }

  Color getInActiveItemColor() {
    return state.lightMode
        ? UTSMEConnectColors.kInActiveItemL
        : UTSMEConnectColors.kInActiveItemD;
  }

  Color getTextColor() {
    return state.lightMode
        ? UTSMEConnectColors.kTextColorL
        : UTSMEConnectColors.kTextColorD;
  }

  Color getTextFieldBorderColor() {
    return state.lightMode
        ? UTSMEConnectColors.kTextFieldBorderL
        : UTSMEConnectColors.kTextFieldBorderD;
  }

  Color getTextFieldErrorBorderColor() {
    return state.lightMode
        ? UTSMEConnectColors.kTextFieldErrorBorderL
        : UTSMEConnectColors.kTextFieldErrorBorderD;
  }

  Color getMinValueColor() {
    return state.lightMode
        ? UTSMEConnectColors.kMinValueL
        : UTSMEConnectColors.kMinValueD;
  }

  Color getMaxValueColor() {
    return state.lightMode
        ? UTSMEConnectColors.kMaxValueL
        : UTSMEConnectColors.kMaxValueD;
  }

  // Interface scaling methods
  double getUiScale() {
    return state.uiScale;
  }

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
  double getPrimaryTextSize() {
    return state.primaryTextSize;
  }

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
  return UTSMEConnectThemeController(UTSMEConnectThemeState(
    lightMode: false,
    uiScale: UTSMEConnectSizes.kDefaultUiScale,
    primaryTextSize: UTSMEConnectSizes.kDefaultPrimaryTextSize,
  ));
});
