import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/features/dashboard/data/remote/dashboard_data.dart';

/// class to contain the properties
class DashboardState {
  double speed;
  double tireTemperature;
  double suspension;

  DashboardState({
    required this.speed,
    required this.tireTemperature,
    required this.suspension,
  });

  DashboardState copyWith({
    required double speed,
    required double tireTemperature,
    required double suspension,
  }) {
    return DashboardState(
      speed: speed,
      tireTemperature: tireTemperature,
      suspension: suspension,
    );
  }
}

/// class to do operations on the properties
class DashboardController extends StateNotifier<DashboardState> {
  DashboardController(super.state) {
    periodicallyUpdateDashboardData();
  }

  void periodicallyUpdateDashboardData() async {
    Timer.periodic(const Duration(microseconds: 1), (timer) {
      state.speed = DashboardData.fetchSpeed();
      state.tireTemperature = DashboardData.fetchTireTemperature();
      state.suspension = DashboardData.fetchSuspension();
    });
    state = state.copyWith(
      speed: state.speed,
      tireTemperature: state.tireTemperature,
      suspension: state.suspension,
    );
  }
}

/// exposing the controller using Riverpod
final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  return DashboardController(DashboardState(
    speed: DashboardData.fetchSpeed(),
    tireTemperature: DashboardData.fetchTireTemperature(),
    suspension: DashboardData.fetchSuspension(),
  ));
});
