import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/features/power/data/remote/power_data.dart';

/// class to contain the properties
class PowerState {
  double charge;
  double minVoltage;
  double maxVoltage;

  PowerState({
    required this.charge,
    required this.minVoltage,
    required this.maxVoltage,
  });

  PowerState copyWith({
    required double charge,
    required double minVoltage,
    required double maxVoltage,
  }) {
    return PowerState(
      charge: charge,
      minVoltage: minVoltage,
      maxVoltage: maxVoltage,
    );
  }
}

/// class to do operations on the properties
class PowerController extends StateNotifier<PowerState> {
  PowerController(super.state) {
    periodicallyUpdateChargeData();
  }

  void periodicallyUpdateChargeData() async {
    Timer.periodic(const Duration(microseconds: 1), (timer) {
      state.charge = PowerData.fetchCharge();
      state.minVoltage = PowerData.fetchMinVoltage();
      state.maxVoltage = PowerData.fetchMaxVoltage();
    });
    state = state.copyWith(
      charge: state.charge,
      minVoltage: state.minVoltage,
      maxVoltage: state.maxVoltage,
    );
  }
}

/// exposing the controller using Riverpod
final powerControllerProvider =
    StateNotifierProvider<PowerController, PowerState>((ref) {
  return PowerController(PowerState(
    charge: PowerData.fetchCharge(),
    minVoltage: PowerData.fetchMinVoltage(),
    maxVoltage: PowerData.fetchMaxVoltage(),
  ));
});
