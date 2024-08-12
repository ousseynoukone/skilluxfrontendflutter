import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'binary_media.g.dart';

@HiveType(typeId: 5)
class BinaryMedia {
  @HiveField(0)
  Uint8List? binaryMedia;

  @HiveField(1)
  String? xFileMediaPath;

  @HiveField(2)
  String? xFileMediaName;

  @HiveField(3)
  String? xFileMediaMimeType;

  BinaryMedia({
    this.binaryMedia,
    this.xFileMediaPath,
    this.xFileMediaName,
    this.xFileMediaMimeType,
  });

  // Clone method
  BinaryMedia clone() {
    return BinaryMedia(
      binaryMedia: binaryMedia != null
          ? Uint8List.fromList(binaryMedia!)
          : null, // Create a copy of the Uint8List
      xFileMediaPath: xFileMediaPath,
      xFileMediaName: xFileMediaName,
      xFileMediaMimeType: xFileMediaMimeType,
    );
  }

    // Function to check if the BinaryMedia instance is empty or null
  bool isEmpty() {
    return binaryMedia == null &&
        (xFileMediaPath == null || xFileMediaPath!.isEmpty) &&
        (xFileMediaName == null || xFileMediaName!.isEmpty) &&
        (xFileMediaMimeType == null || xFileMediaMimeType!.isEmpty);
  }
}
