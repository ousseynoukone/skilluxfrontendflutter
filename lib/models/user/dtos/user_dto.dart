import 'package:flutter/material.dart';

class UserDTO {
  final int ? id;
  final String fullName;
  final String username;
  final String? email;
  final String? profilePicture;
  final String? profession; // New profession field

  UserDTO({
     this.id,
    required this.fullName,
    required this.username,
    this.email,
    this.profilePicture,
    this.profession, // Added in the constructor
  });

  // Factory constructor to create a UserDTO from a Map
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      profession: json['profession'], // Added profession field
    );
  }

  // Method to create a UserDTO from a Map (alternative to fromJson)
  static UserDTO fromBody(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      profession: json['profession'], // Added profession field
    );
  }

  // Method to convert UserDTO to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'profession': profession, // Added profession field
    };
  }

  // Clone method to create a deep copy of UserDTO
  UserDTO clone() {
    return UserDTO(
      id: id,
      fullName: fullName,
      username: username,
      email: email,
      profilePicture: profilePicture,
      profession: profession, // Added profession field
    );
  }

  @override
  String toString() {
    return 'UserDTO(id: $id, fullName: $fullName, username: $username, email: $email, profilePicture: $profilePicture, profession: $profession)';
  }
}
