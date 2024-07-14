import 'dart:math';

// Singleton class to contact the endpoint
// to fetch information about the car dashboard
class DashboardData {
  DashboardData._();

  static double fetchSpeed() {
    //fetch the charge
    return Random().nextInt(150).toDouble();
  }

  static double fetchTireTemperature() {
    //fetch the tire temperature
    return Random().nextInt(80).toDouble();
  }

  static double fetchSuspension() {
    //fetch the suspension
    return Random().nextInt(250).toDouble();
  }
}
