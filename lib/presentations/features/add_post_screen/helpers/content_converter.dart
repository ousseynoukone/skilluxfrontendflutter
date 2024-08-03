import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DocumentConverter {
  static Document? convertToDocument(String content) {
    final Logger _logger = Logger();

    Document? document;
    try {
      document = Document.fromJson(jsonDecode(content));
     
    } catch (e) {
      _logger.e(e.toString());
    }
    return document;
  }

  static String? convertToJsonString(Document document) {
    final Logger _logger = Logger();

    String? jsonString;
    try {
      jsonString = jsonEncode(document.toDelta().toJson());
    } catch (e) {
      _logger.e(e.toString());
    }
    return jsonString;
  }
}
