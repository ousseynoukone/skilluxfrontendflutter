import 'dart:typed_data';  
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
  ///  XFile needs a file path.  
  static Future<XFile?> uint8ListToXFile(Uint8List bytes, String path) async {  
    final File tempFile = File(path);  
    // Write the bytes to a temporary file  
    await tempFile.writeAsBytes(bytes);  

    // Return an XFile created from the temporary file  
    return XFile(tempFile.path);  
  }  
}