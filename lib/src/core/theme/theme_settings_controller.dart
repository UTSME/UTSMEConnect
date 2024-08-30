import 'package:hive/hive.dart';
import 'package:utsmeconnect/src/core/constants/utsmeconnect_sizes.dart';
import 'package:utsmeconnect/src/core/theme/theme_settings_model.dart';

class ThemeSettingsController {
  static late ThemeSettingsController _instance;
  static bool _wasInitialized = false;
  final themeSettingsStorage = Hive.box<ThemeSettingsModel>("theme_settings");

  ThemeSettingsController._();

  static ThemeSettingsController instance() {
    if (!_wasInitialized) {
      _instance = ThemeSettingsController._();
      _wasInitialized = true;
    }

    _instance.initStorage();
    return _instance;
  }

  // Initialize the persistent local storage
  void initStorage() {
    if (themeSettingsStorage.values.isEmpty) {
      ThemeSettingsModel themeSettingsModel = const ThemeSettingsModel(
        darkMode: false,
        uiScale: UTSMEConnectSizes.kDefaultUiScale,
        primaryTextSize: UTSMEConnectSizes.kDefaultPrimaryTextSize,
      );
      themeSettingsStorage.add(themeSettingsModel);
    }
  }

  void updateThemeSettings(
      bool darkMode, double uiScale, double primaryTextSize) {
    themeSettingsStorage.putAt(
        0,
        themeSettingsStorage.values.first.copyWith(
          darkMode: darkMode,
          uiScale: uiScale,
          primaryTextSize: primaryTextSize,
        ));
  }

  ThemeSettingsModel getThemeSettings() {
    return themeSettingsStorage.values.first;
  }
}
