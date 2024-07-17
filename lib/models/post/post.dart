import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';

class Post {
  final int? id;
  final String title;
  final int? readNumber;
  final int? votesNumber;
  final bool? isPublished;
  final String ? headerImageUrl;
  final List<String> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;
  final List<Section>? sections;

  // For future purpose
  final XFile? headerImageIMG;

  Post({
    this.id,
    required this.title,
    this.readNumber = 0,
    this.votesNumber = 0,
    this.isPublished = false,
    this.headerImageUrl,
    required this.tags,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.sections,
    this.headerImageIMG,
  });

  factory Post.fromBody(Map<String, dynamic> body) {
    return Post(
      id: body['id'],
      title: body['title'],
      readNumber: body['readNumber'],
      votesNumber: body['votesNumber'],
      isPublished: body['isPublished'],
      headerImageUrl: body['headerImage'],
      tags: List<String>.from(body['tags']),
      createdAt: body['createdAt'] != null ? DateTime.parse(body['createdAt']) : null,
      updatedAt: body['updatedAt'] != null ? DateTime.parse(body['updatedAt']) : null,
      userId: body['userId'],
      sections: (body['sections'] != null)
          ? List<Section>.from(
              body['sections'].map((section) => Section.fromBody(section)))
          : null,
      headerImageIMG: null,
    );
  }

  Map<String, dynamic> toBody() {
    return {
      'id': id,
      'title': title,
      'headerImage': headerImageUrl,
      'tags': tags,
      'userId': userId,
      'sections': sections?.map((section) => section.toBody()).toList(),
    };
  }


}