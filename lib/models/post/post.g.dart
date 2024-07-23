// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 6;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      id: fields[0] as int?,
      title: fields[1] as String,
      readNumber: fields[2] as int?,
      votesNumber: fields[3] as int?,
      isPublished: fields[4] as bool?,
      headerImageUrl: fields[5] as String?,
      tags: (fields[6] as List).cast<String>(),
      createdAt: fields[7] as DateTime?,
      updatedAt: fields[8] as DateTime?,
      userId: fields[9] as int?,
      content: fields[10] as String,
      headerBinaryImage: fields[11] as BinaryImage?,
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.readNumber)
      ..writeByte(3)
      ..write(obj.votesNumber)
      ..writeByte(4)
      ..write(obj.isPublished)
      ..writeByte(5)
      ..write(obj.headerImageUrl)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.content)
      ..writeByte(11)
      ..write(obj.headerBinaryImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
