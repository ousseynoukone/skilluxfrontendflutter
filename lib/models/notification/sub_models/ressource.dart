import 'package:skilluxfrontendflutter/models/comment/comment.dart';

class Ressource {
  final int id;
  final int? postId;
  final String? title;
  final String? text;
  final String? headerImage;
  final Comment? parentComment;

  Ressource(
      {required this.id,
      this.postId,
      this.title,
      this.text,
      this.headerImage,
      this.parentComment});

  // Factory method to create a Ressource from a Map (e.g., from JSON)
  factory Ressource.fromBody(Map<String, dynamic> json) {
    return Ressource(
        id: json['id'] as int,
        postId: json['postId'] != null ? json['postId'] as int : null,
        title: json['title'] as String?,
        text: json['text'] as String?,
        headerImage: json['headerImage'] as String?,
        parentComment: json['parentComment'] == null
            ? null
            : Comment.fromJson(json['parentComment']));
  }
}
