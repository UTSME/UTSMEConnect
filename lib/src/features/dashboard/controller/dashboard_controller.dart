import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utsmeconnect/src/features/dashboard/data/remote/dashboard_data.dart';

/// class to contain the properties
class DashboardState {
  double speed;

  DashboardState({required this.speed});

  DashboardState copyWith({
    required double speed,
  }) {
    return DashboardState(
      speed: speed,
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
    });
    state = state.copyWith(speed: state.speed);
  }
}

/// exposing the controller using Riverpod
final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardState>((ref) {
  return DashboardController(DashboardState(speed: DashboardData.fetchSpeed()));
});
