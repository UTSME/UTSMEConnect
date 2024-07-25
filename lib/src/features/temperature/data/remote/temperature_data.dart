import 'dart:math';

import 'package:utsmeconnect/src/core/constants/utsmeconnect_values.dart';

// Singleton class to contact the endpoint
// to fetch information about the car temperatures
class TemperatureData {
  TemperatureData._();

  static double fetchTireTemperature() {
    //fetch the tire temperature
    return Random().nextInt(UTSMEConnectValues.kTireTemperature).toDouble();
  }
}
