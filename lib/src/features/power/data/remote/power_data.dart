import 'dart:math';

import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';

// Singleton class to contact the endpoint
// to fetch information about the car power
class PowerData {
  PowerData._();

  static double fetchCharge() {
    //fetch the charge data
    return Random().nextInt(UTSMEConnectValues.kCharge).toDouble();
  }

  static double fetchMinVoltage() {
    //fetch the min voltage data
    return Random().nextInt(UTSMEConnectValues.kMinVoltage).toDouble();
  }

  static double fetchMaxVoltage() {
    //fetch the max voltage data
    return Random().nextInt(UTSMEConnectValues.kMaxVoltage - 50).toDouble() +
        50;
  }
}
