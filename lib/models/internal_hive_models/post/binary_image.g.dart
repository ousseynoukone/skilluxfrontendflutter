// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'binary_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BinaryImageAdapter extends TypeAdapter<BinaryImage> {
  @override
  final int typeId = 5;

  @override
  BinaryImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BinaryImage(
      binaryImage: fields[0] as Uint8List?,
      xFileImagePath: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BinaryImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.binaryImage)
      ..writeByte(1)
      ..write(obj.xFileImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BinaryImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
