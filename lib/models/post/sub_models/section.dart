
import 'package:flutter/material.dart';

class Section {
  final int? id;
  final String content;

  Section({this.id, required this.content});

  // Method to convert UserRegisterDto object to JSON
  Map<String, dynamic> toBody() {
    return {
      'id': id,
      'content': content,
    };
  }

  // Static method to create UserRegisterDto object from JSON
  static Section fromBody(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      content: json['content'],
    );
  }
}
