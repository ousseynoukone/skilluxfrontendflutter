// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppConfigStateAdapter extends TypeAdapter<AppConfigState> {
  @override
  final int typeId = 1;

  @override
  AppConfigState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfigState(
      isAppFirstLaunch: fields[1] as bool?,
      isUserLogged: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfigState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isUserLogged)
      ..writeByte(1)
      ..write(obj.isAppFirstLaunch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
