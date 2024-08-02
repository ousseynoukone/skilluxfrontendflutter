// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binary_media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BinaryMediaAdapter extends TypeAdapter<BinaryMedia> {
  @override
  final int typeId = 5;

  @override
  BinaryMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BinaryMedia(
      binaryMedia: fields[0] as Uint8List?,
      xFileMediaPath: fields[1] as String?,
      xFileMediaName: fields[2] as String?,
      xFileMediaMimeType: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BinaryMedia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.binaryMedia)
      ..writeByte(1)
      ..write(obj.xFileMediaPath)
      ..writeByte(2)
      ..write(obj.xFileMediaName)
      ..writeByte(3)
      ..write(obj.xFileMediaMimeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BinaryMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
