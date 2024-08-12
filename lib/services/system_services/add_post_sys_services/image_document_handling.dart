import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/content_converter.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';

class QuillMediaHandler {
  /// Extracts image files from a Quill document
  static Future<List<XFile>> extractMediasFromDocument(String content) async {
    final Logger _logger = Logger();

    Document document =
        DocumentConverter.convertToDocument(content) ?? Document();
    Delta delta = document.toDelta();
    List<XFile> extractedFile = [];

    for (var operation in delta.toList()) {
      if (operation.key == 'insert' &&
          operation.value is Map &&
          (operation.value['image'] != null ||
              operation.value['video'] != null)) {
        final String localPath =
            operation.value['image'] ?? operation.value['video'];
        XFile _xfile = XFile(localPath);

        if (await _xfile.length() > 0) {
          final List<int> bytes = await _xfile.readAsBytes();
          final mimeType = lookupMimeType(_xfile.path, headerBytes: bytes);
          final fileExtension = mimeType!.split('/').last;
          var uuid = const Uuid();
          String fileName = "${uuid.v1()}.$fileExtension";
          extractedFile
              .add(XFile(_xfile.path, name: fileName, mimeType: mimeType));
        } else {
          _logger.w('Image file not found: $localPath');
        }
      }
    }

    return extractedFile;
  }

  /// Inserts image files into a Quill document
  static Future<String> insertMediasIntoDocument(
      String content, List<XFile> medias) async {
    final Logger _logger = Logger();

    Document document =
        DocumentConverter.convertToDocument(content) ?? Document();
    Delta delta = document.toDelta();
    List<Operation> list = delta.toList();
    List<Operation> newOperations = [];
    int fileIndex = 0;

    for (var op in delta.toList()) {
      if (op.key == 'insert' &&
          op.data is Map &&
          (op.value['image'] != null || op.value['video'] != null)) {
        String mediaType = op.value['image'] != null ? "image" : "video";
        if (fileIndex < medias.length) {
          var newOp = Operation.insert(
              {mediaType: medias[fileIndex].path}, op.attributes);
          newOperations.add(newOp);
          fileIndex++;
        } else {
          newOperations.add(op);
        }
      } else {
        newOperations.add(op);
      }
    }

    // Create a new document with updated delta
    Delta newDelta = Delta.fromOperations(newOperations);
    Document newDocument = Document.fromDelta(newDelta);
    String jsonToString = DocumentConverter.convertToJsonString(newDocument)!;

    return jsonToString;
  }
}
