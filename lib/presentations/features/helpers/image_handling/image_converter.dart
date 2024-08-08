import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageConverter {
  /// Converts an XFile to Uint8List.
  static Future<Uint8List?> xFileToUint8List(XFile? file) async {
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  /// Converts Uint8List to XFile.
  static Future<XFile?> uint8ListToXFile(Uint8List bytes, String path,String name,String mimeType ) async {
    return XFile.fromData(bytes,name: name,mimeType: mimeType,path: path);
  }
}
