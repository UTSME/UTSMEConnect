import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part "theme_settings_model.g.dart";

@HiveType(typeId: 0)
class ThemeSettingsModel extends Equatable {
  @HiveField(0)
  final bool darkMode;
  @HiveField(1)
  final double uiScale;
  @HiveField(2)
  final double primaryTextSize;

  const ThemeSettingsModel({
    required this.darkMode,
    required this.uiScale,
    required this.primaryTextSize,
  });

  ThemeSettingsModel copyWith({
    bool? darkMode,
    double? uiScale,
    double? primaryTextSize,
  }) {
    return ThemeSettingsModel(
      darkMode: darkMode ?? this.darkMode,
      uiScale: uiScale ?? this.uiScale,
      primaryTextSize: primaryTextSize ?? this.primaryTextSize,
    );
  }

  @override
  List<Object?> get props => [];
}
