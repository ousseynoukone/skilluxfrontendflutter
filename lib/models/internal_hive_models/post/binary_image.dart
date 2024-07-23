import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'binary_image.g.dart';

@HiveType(typeId: 5)
class BinaryImage {
  @HiveField(0)
  Uint8List ? binaryImage;
  @HiveField(1)
  String ? xFileImagePath;

  BinaryImage({ this.binaryImage,  this.xFileImagePath});
}
