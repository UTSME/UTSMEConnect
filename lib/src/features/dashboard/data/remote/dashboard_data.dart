import 'dart:math';

// Singleton class to contact the endpoint
// to fetch information about the car dashboard
class DashboardData {
  DashboardData._();

  static double fetchSpeed() {
    //fetch the charge data each 5 seconds
    return Random().nextInt(150).toDouble();
  }
}
