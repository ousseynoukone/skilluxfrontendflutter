import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final bool? isAdmin;


  @HiveField(1)
  final bool? isActive;

  @HiveField(2)
  List<String>? preferredTags;

  @HiveField(3)
  final int id;

  @HiveField(4)
  final String username;

  @HiveField(5)
  String fullName;

  @HiveField(6)
  String email;

  @HiveField(7)
  final String birth;

  @HiveField(8)
  final String? updatedAt;

  @HiveField(9)
  final String? createdAt;

  @HiveField(10)
  String? profession;

  @HiveField(11)
  String? profilePicture;

  User({
    this.isAdmin,
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

User copyWith({
    bool? isAdmin,
    String? token,
    String? expire,
    bool? isActive,
    List<String>? preferredTags,
    int? id,
    String? username,
    String? fullName,
    String? email,
    String? birth,
    String? updatedAt,
    String? createdAt,
    String? profession,
    String? profilePicture,
  }) {
    return User(
      isAdmin: isAdmin ?? this.isAdmin,
      isActive: isActive ?? this.isActive,
      preferredTags: preferredTags ?? this.preferredTags,
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      birth: birth ?? this.birth,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      profession: profession ?? this.profession,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }}
