// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      isAdmin: fields[0] as bool?,
      token: fields[1] as String?,
      expire: fields[2] as String?,
      isActive: fields[3] as bool?,
      preferredTags: (fields[4] as List?)?.cast<String>(),
      id: fields[5] as int,
      username: fields[6] as String,
      fullName: fields[7] as String,
      email: fields[8] as String,
      birth: fields[9] as String,
      updatedAt: fields[10] as String?,
      createdAt: fields[11] as String?,
      profession: fields[12] as String?,
      profilePicture: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.isAdmin)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.expire)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.preferredTags)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.fullName)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.birth)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.profession)
      ..writeByte(13)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
