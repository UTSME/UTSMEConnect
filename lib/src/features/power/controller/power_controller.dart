import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/features/power/data/remote/power_data.dart';

/// class to contain the properties
class PowerState {
  double charge;

  PowerState({required this.charge});

  PowerState copyWith({
    required double charge,
  }) {
    return PowerState(
      charge: charge,
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
    });
    state = state.copyWith(charge: state.charge);
  }
}

/// exposing the controller using Riverpod
final powerControllerProvider =
    StateNotifierProvider<PowerController, PowerState>((ref) {
  return PowerController(PowerState(charge: PowerData.fetchCharge()));
});
