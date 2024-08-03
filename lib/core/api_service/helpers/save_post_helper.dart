import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:logger/logger.dart';
import 'package:http_parser/http_parser.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

Map<String, String> buildRequestFieldsForPost(Post post) {
  final Logger _logger = Logger();
  final Map<String, String> fields = {};

  try {
    fields['title'] = post.title;
    fields['readNumber'] = post.readNumber?.toString() ?? '0';
    fields['votesNumber'] = post.votesNumber?.toString() ?? '0';
    fields['isPublished'] = post.isPublished?.toString() ?? 'false';
    fields['headerImageUrl'] = post.headerImageUrl ?? '';
    fields['tags'] = jsonEncode(post.tags);
    for (int i = 0; i < post.tags.length; i++) {
      fields['tags[]'] = post.tags[i];
    }

    fields['createdAt'] = post.createdAt?.toIso8601String() ?? '';
    fields['updatedAt'] = post.updatedAt?.toIso8601String() ?? '';
    fields['userId'] = post.userId?.toString() ?? '';
    fields['content'] = post.content.content!;
  } catch (e) {
    _logger.e(e);
  }

  return fields;
}

Future<http.MultipartFile> createMultipartFile(
    XFile file, String fieldName) async {
  var stream = http.ByteStream(file.openRead());
  var length = await file.length();
  var mimeTypeSplited = file.mimeType!.split('/');
  var multipartFile = http.MultipartFile(fieldName, stream, length,
      filename: file.name,
      contentType: MediaType(mimeTypeSplited.first, mimeTypeSplited.last));
  return multipartFile;
}
