import 'dart:math';

// Singleton class to contact the endpoint
// to fetch information about the car power
class PowerData {
  PowerData._();

  static double fetchCharge() {
    return Random().nextInt(100).toDouble();
  }
}
