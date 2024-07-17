
import 'package:flutter/material.dart';

class Section {
  final int? id;
  final String? title;

  final String? media;
  final String content;

  // For featuring purpose
  final Image ? image;

  Section({this.title, this.id, required this.content, this.media,this.image});

  // Method to convert UserRegisterDto object to JSON
  Map<String, dynamic> toBody() {
    return {
      'id': id,
      'media': media,
      'content': content,
      'title': title,
    };
  }

  // Static method to create UserRegisterDto object from JSON
  static Section fromBody(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      media: json['media'],
    );
  }
}
