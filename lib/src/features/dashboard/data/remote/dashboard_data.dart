import 'dart:math';

import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';

// Singleton class to contact the endpoint
// to fetch information about the car dashboard
class DashboardData {
  DashboardData._();

  static double fetchSpeed() {
    //fetch the charge
    return Random().nextInt(UTSMEConnectValues.kMaxSpeed).toDouble();
  }

  static double fetchSuspension() {
    //fetch the suspension
    return Random().nextInt(UTSMEConnectValues.kSuspension).toDouble();
  }
}
