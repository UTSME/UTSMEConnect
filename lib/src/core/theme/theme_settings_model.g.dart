// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeSettingsModelAdapter extends TypeAdapter<ThemeSettingsModel> {
  @override
  final int typeId = 0;

  @override
  ThemeSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeSettingsModel(
      darkMode: fields[0] as bool,
      uiScale: fields[1] as double,
      primaryTextSize: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeSettingsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.uiScale)
      ..writeByte(2)
      ..write(obj.primaryTextSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
