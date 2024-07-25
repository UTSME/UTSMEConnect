import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/features/temperature/data/remote/temperature_data.dart';

/// class to contain the properties
class TemperatureState {
  double tireTemperature;

  TemperatureState({
    required this.tireTemperature,
  });

  TemperatureState copyWith({
    required double tireTemperature,
  }) {
    return TemperatureState(
      tireTemperature: tireTemperature,
    );
  }
}

/// class to do operations on the properties
class TemperatureController extends StateNotifier<TemperatureState> {
  TemperatureController(super.state) {
    periodicallyUpdateTemperatureData();
  }

  void periodicallyUpdateTemperatureData() async {
    Timer.periodic(const Duration(microseconds: 1), (timer) {
      state.tireTemperature = TemperatureData.fetchTireTemperature();
    });
    state = state.copyWith(
      tireTemperature: state.tireTemperature,
    );
  }
}

/// exposing the controller using Riverpod
final temperatureControllerProvider =
    StateNotifierProvider<TemperatureController, TemperatureState>((ref) {
  return TemperatureController(TemperatureState(
    tireTemperature: TemperatureData.fetchTireTemperature(),
  ));
});
