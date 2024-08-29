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
      isActive: fields[1] as bool?,
      preferredTags: (fields[2] as List?)?.cast<String>(),
      id: fields[3] as int,
      username: fields[4] as String,
      fullName: fields[5] as String,
      email: fields[6] as String,
      birth: fields[7] as String,
      lang: fields[15] as String?,
      updatedAt: fields[8] as String?,
      createdAt: fields[9] as String?,
      profession: fields[10] as String?,
      profilePicture: fields[11] as String?,
      nbFollowers: fields[12] as int,
      nbFollowings: fields[13] as int,
      nbPosts: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.isAdmin)
      ..writeByte(1)
      ..write(obj.isActive)
      ..writeByte(2)
      ..write(obj.preferredTags)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.username)
      ..writeByte(5)
      ..write(obj.fullName)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.birth)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.profession)
      ..writeByte(11)
      ..write(obj.profilePicture)
      ..writeByte(12)
      ..write(obj.nbFollowers)
      ..writeByte(13)
      ..write(obj.nbFollowings)
      ..writeByte(14)
      ..write(obj.nbPosts)
      ..writeByte(15)
      ..write(obj.lang);
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
