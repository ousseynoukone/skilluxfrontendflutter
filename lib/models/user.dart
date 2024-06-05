
import 'dart:ffi';

class User  {
  final bool? isAdmin;
  String? token;
  int ? expire;
  final bool? isActive;
  List<String>? preferredTags;
  final int id;
  final String username;
  String fullName;
  String email;
  final String birth;
  final String? updatedAt;
  final String? createdAt;
  String? profession;
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
      preferredTags: json['preferredTags'],
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
  

}
