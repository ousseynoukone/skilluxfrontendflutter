import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/content/content.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/post/binary_media.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/image_handling/image_converter.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/image_document_handling.dart';

part 'post.g.dart'; // This will be generated by Hive

@HiveType(typeId: 6) // Unique type ID for the Post model
class Post {
  final Logger _logger = Logger();

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int? readNumber;

  @HiveField(3)
  int? votesNumber;

  @HiveField(4)
  final bool? isPublished;

  @HiveField(5)
  final String? headerImageUrl;

  @HiveField(6)
  final List<String> tags;

  @HiveField(7)
  DateTime? createdAt;

  @HiveField(8)
  final DateTime? updatedAt;

  @HiveField(9)
  final int? userId;

  @HiveField(10)
  Content content;

  @HiveField(11)
  BinaryMedia? headerBinaryImage;

  @HiveField(12)
  int commentNumber;

  // User information of fetched post
  UserDTO? user;
  // For implementation purpose
  XFile? headerImageIMG;

  Post({
    this.id,
    required this.title,
    this.readNumber = 0,
    this.votesNumber = 0,
    this.commentNumber = 0,
    this.isPublished = false,
    this.headerImageUrl,
    required this.tags,
    this.createdAt,
    this.updatedAt,
    this.userId,
    required this.content,
    this.headerImageIMG,
    this.headerBinaryImage,
    this.user,
  });

  factory Post.fromBody(Map<String, dynamic> body) {
    var userJson = body['User'];
    return Post(
      id: body['id'],
      title: body['title'],
      readNumber: body['readNumber'],
      votesNumber: body['votesNumber'],
      isPublished: body['isPublished'],
      commentNumber: body['commentCount'] ?? 0,
      headerImageUrl: body['headerImage'],
      tags: List<String>.from(body['tags']),
      createdAt:
          body['createdAt'] != null ? DateTime.parse(body['createdAt']) : null,
      updatedAt:
          body['updatedAt'] != null ? DateTime.parse(body['updatedAt']) : null,
      userId: body['userId'],
      content: Content(content: body['content']),
      headerImageIMG: null, // Populate this as necessary
      user: userJson != null ? UserDTO.fromJson(userJson) : null,
    );
  }

  Map<String, dynamic> toBody() {
    return {
      'id': id,
      'title': title,
      'headerImage': headerImageUrl,
      'tags': tags,
      'userId': userId,
      'content': content,
    };
  }

  Future<bool> convertheaderImageXFileImageToBinary() async {
    try {
      if (headerImageIMG != null) {
        headerBinaryImage ??= BinaryMedia();

        headerBinaryImage!.binaryMedia =
            await ImageConverter.xFileToUint8List(headerImageIMG);

        headerBinaryImage!.xFileMediaPath = headerImageIMG!.path;
        headerBinaryImage!.xFileMediaName = headerImageIMG!.name;
        headerBinaryImage!.xFileMediaMimeType = headerImageIMG!.mimeType;
        return true;
      } else {
        return true;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return false;
  }

  Future<bool> convertHeaderImageBinaryToXFileImage() async {
    try {
      if (headerBinaryImage?.binaryMedia != null) {
        headerImageIMG = await ImageConverter.uint8ListToXFile(
            headerBinaryImage!.binaryMedia!,
            headerBinaryImage!.xFileMediaPath!,
            headerBinaryImage!.xFileMediaName!,
            headerBinaryImage!.xFileMediaMimeType!);
        return true;
      }
      if (headerImageIMG == null) {
        return true;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return false;
  }

  Post copyWith({
    int? id,
    String? title,
    int? readNumber,
    int? votesNumber,
    int? commentNumber,
    bool? isPublished,
    String? headerImageUrl,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    Content? content,
    XFile? headerImageIMG,
    BinaryMedia? headerImageBinary,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      readNumber: readNumber ?? this.readNumber,
      commentNumber: commentNumber ?? this.commentNumber,
      votesNumber: votesNumber ?? this.votesNumber,
      isPublished: isPublished ?? this.isPublished,
      headerImageUrl: headerImageUrl ?? this.headerImageUrl,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      headerImageIMG: headerImageIMG ?? this.headerImageIMG,
      headerBinaryImage: headerImageBinary ?? headerBinaryImage,
    );
  }

  //This function will extract all the media within content.content and fill the content.xFileMediaList with the media
  Future<bool> extractMediaFromContent() async {
    try {
      if (content.content!.isNotEmpty) {
        List<XFile> _xFiles =
            await QuillMediaHandler.extractMediasFromDocument(content.content!);
        content.xFileMediaList.clear();
        for (XFile _file in _xFiles) {
          content.xFileMediaList.add(_file);
        }
        _logger.w(content.xFileMediaList.length);
        return true;
      } else {
        _logger.e("content.content IS EMPTY!");
        return false;
      }
    } catch (e) {
      _logger.e(e.toString());

      return false;
    }
  }

  //This function will convert all media in xFileMediaList to binary int in order to store them in hive

  Future<bool> convertxFileMediaListToBinary() async {
    try {
      await extractMediaFromContent();
      List<XFile> _xFiles = content.xFileMediaList;
      if (_xFiles.isNotEmpty) {
        for (XFile file in _xFiles) {
          Uint8List? convertedMedia =
              await ImageConverter.xFileToUint8List(file);
          if (convertedMedia != null) {
            BinaryMedia binaryMedia = BinaryMedia(
                binaryMedia: convertedMedia,
                xFileMediaPath: file.path,
                xFileMediaName: file.name,
                xFileMediaMimeType: file.mimeType);

            content.xFileMediaBinaryList.add(binaryMedia);
          }
        }
      }

      return true;
    } catch (e) {
      _logger.d(e.toString());
      return false;
    }
  }

// This function serves to convert xFileMediaBinaryList to Xfile and add them to xFileMediaList
  Future<bool> convertBinaryMediaListToxFile() async {
    try {
      List<BinaryMedia> binaryMediaList = content.xFileMediaBinaryList;

      if (binaryMediaList.isNotEmpty) {
        for (BinaryMedia binaryMedia in binaryMediaList) {
          XFile? xFileMedia = await ImageConverter.uint8ListToXFile(
              binaryMedia.binaryMedia!,
              binaryMedia.xFileMediaPath!,
              binaryMedia.xFileMediaName!,
              binaryMedia.xFileMediaMimeType!);

          if (xFileMedia != null) {
            content.xFileMediaList.add(xFileMedia);
          }
        }

        await insertMediasIntoContent();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertMediasIntoContent() async {
    try {
      content.content = await QuillMediaHandler.insertMediasIntoDocument(
          content.content!, content.xFileMediaList);

      return true;
    } catch (e) {
      return false;
    }
  }

  Post clone() {
    return Post(
      id: id,
      title: title,
      readNumber: readNumber,
      commentNumber: commentNumber,
      votesNumber: votesNumber,
      isPublished: isPublished,
      headerImageUrl: headerImageUrl,
      tags: List<String>.from(
          tags), // Create a new list to avoid reference issues
      createdAt: createdAt?.toUtc(), // Optional: Clone DateTime as needed
      updatedAt: updatedAt?.toUtc(),
      userId: userId,
      content: content.clone(), // Assuming Content has a clone method
      // Assuming BinaryImage also has a clone method or you do a custom deep copy
      headerBinaryImage: headerBinaryImage
          ?.clone(), // Modify if you have a clone method in BinaryImage
      headerImageIMG:
          headerImageIMG, // XFile doesn't need to be cloned, as it's typically immutable
    );
  }

  // Method to like the post
  void like() {
    votesNumber = (votesNumber ?? 0) + 1; // Increment likes
  }

  // Method to unlike the post
  void unlike() {
    votesNumber = (votesNumber ?? 1) - 1; // Decrement likes
  }

  void dump() {
    _logger.d('Post Dump:');
    _logger.d('ID: $id');
    _logger.d('Title: $title');
    _logger.d('Read Number: $readNumber');
    _logger.d('Comment Number: $commentNumber');
    _logger.d('Votes Number: $votesNumber');
    _logger.d('Is Published: $isPublished');
    _logger.d('Header Image URL: $headerImageUrl');
    _logger.d('Tags: $tags');
    _logger.d('Created At: ${createdAt?.toIso8601String() ?? "Not set"}');
    _logger.d('Updated At: ${updatedAt?.toIso8601String() ?? "Not set"}');
    _logger.d('User ID: $userId');
    _logger.d('Content: ${content.dump()}');
    _logger.d('Header Image (XFile): ${headerImageIMG?.path ?? "Not set"}');
    _logger.d(
        'Header Binary Image: ${headerBinaryImage != null ? "Present" : "Not present"}');
    if (headerBinaryImage != null) {
      _logger.d(
          '  Binary Image Path: ${headerBinaryImage!.xFileMediaPath ?? "Not set"}');
      _logger.d(
          '  Binary Image Data: ${headerBinaryImage!.binaryMedia != null ? "${headerBinaryImage!.binaryMedia!.length} bytes" : "Not set"}');
    }
  }
}
