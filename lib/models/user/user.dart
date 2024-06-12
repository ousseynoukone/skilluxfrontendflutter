import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final bool? isAdmin;

  @HiveField(1)
  String? token;

  @HiveField(2)
  int? expire;

  @HiveField(3)
  final bool? isActive;

  @HiveField(4)
  List<String>? preferredTags;

  @HiveField(5)
  final int id;

  @HiveField(6)
  final String username;

  @HiveField(7)
  String fullName;

  @HiveField(8)
  String email;

  @HiveField(9)
  final String birth;

  @HiveField(10)
  final String? updatedAt;

  @HiveField(11)
  final String? createdAt;

  @HiveField(12)
  String? profession;

  @HiveField(13)
  String? profilePicture;

  User({
    this.isAdmin,
    this.token,
    this.expire,
    this.isActive,
    this.preferredTags,
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.birth,
    this.updatedAt,
    this.createdAt,
    this.profession,
    this.profilePicture,
  });

  factory User.fromBody(Map<String, dynamic> json) {
    return User(
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      preferredTags: json['preferredTags'] != null ? List<String>.from(json['preferredTags']) : null,
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      birth: json['birth'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      profession: json['profession'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAdmin': isAdmin,
      'token': token,
      'expire': expire,
      'isActive': isActive,
      'preferredTags': preferredTags,
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'birth': birth,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'profession': profession,
      'profilePicture': profilePicture,
    };
  }
}
