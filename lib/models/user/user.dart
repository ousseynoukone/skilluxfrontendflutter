import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';

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

  @HiveField(12)
  int nbFollowers;

  @HiveField(13)
  int nbFollowings;

  @HiveField(14)
  int nbPosts;

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
    this.nbFollowers = 0,
    this.nbFollowings = 0,
    this.nbPosts = 0,
  });

  factory User.fromBody(Map<String, dynamic> json) {
    return User(
      isAdmin: json['isAdmin'],
      isActive: json['isActive'],
      preferredTags: json['preferredTags'] != null
          ? List<String>.from(json['preferredTags'])
          : null,
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      birth: json['birth'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      profession: json['profession'],
      profilePicture: json['profilePicture'],
      nbFollowers: json['nbFollowers'] ?? 0,
      nbFollowings: json['nbFollowings'] ?? 0,
      nbPosts: json['nbPosts'] ?? 0,
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

  // Check if fields are empty or null

  // Check if fields are empty or null
  bool isEmpty() {
    return (username.isEmpty ||
            fullName.isEmpty ||
            email.isEmpty ||
            birth.isEmpty) &&
        (preferredTags?.isEmpty ?? true) &&
        (profession?.isEmpty ?? true) &&
        (profilePicture?.isEmpty ?? true) &&
        (nbFollowers == 0) &&
        (nbFollowings == 0) &&
        (nbPosts == 0); // Check for new fields
  }

  Future<bool> isConnectedUser(User user) async {
    try {
      final controller = Get.find<HiveUserPersistence>();
      User? storedUser = await controller.readUser();
      if (storedUser == null) {
        return false;
      } else {
        if (user.id == storedUser.id) {
          return true;
        }
      }
    } catch (e) {
      print("Error reading user: $e");
      // Handle the error as needed (e.g., logging, rethrowing, etc.)
    }
    return false;
  }

User clone() {
    return User(
      isAdmin: this.isAdmin,
      isActive: this.isActive,
      preferredTags: this.preferredTags != null
          ? List<String>.from(this.preferredTags!)
          : null,
      id: this.id,
      username: this.username,
      fullName: this.fullName,
      email: this.email,
      birth: this.birth,
      updatedAt: this.updatedAt,
      createdAt: this.createdAt,
      profession: this.profession,
      profilePicture: this.profilePicture,
      nbFollowers: this.nbFollowers,
      nbFollowings: this.nbFollowings,
      nbPosts: this.nbPosts,
    );
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
    int? nbFollowers,
    int? nbFollowings,
    int? nbPosts,
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
      nbFollowers: nbFollowers ?? this.nbFollowers,
      nbFollowings: nbFollowings ?? this.nbFollowings,
      nbPosts: nbPosts ?? this.nbPosts,
    );
  }
}
