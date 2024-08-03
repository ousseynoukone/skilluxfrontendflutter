import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/post/binary_media.dart';

part 'content.g.dart';

@HiveType(typeId: 7)
class Content {
  @HiveField(0)
  String? content;

  @HiveField(1)
  List<BinaryMedia> xFileMediaBinaryList;

  // This won't be stored
  List<XFile> xFileMediaList;

  Content({
    this.content,
    List<XFile>? xFileMediaList,
    List<BinaryMedia>? xFileMediaBinaryList,
  }) : xFileMediaList = xFileMediaList ?? [],
       xFileMediaBinaryList = xFileMediaBinaryList ?? [];

  // Clone method
  Content clone() {
    return Content(
      content: content,
      xFileMediaList: List<XFile>.from(xFileMediaList),
      xFileMediaBinaryList: List<BinaryMedia>.from(xFileMediaBinaryList),
    );
  }

  // Dump function
  String dump() {
    StringBuffer buffer = StringBuffer();

    buffer.writeln('Content:');
    buffer.writeln('  Content: $content');
    buffer.writeln('  xFileMediaBinaryList (${xFileMediaBinaryList.length}):');
    for (var binaryMedia in xFileMediaBinaryList) {
      buffer.writeln('    - ${binaryMedia.toString()}');
    }
    buffer.writeln('  xFileMediaList (${xFileMediaList.length}):');
    for (var xfile in xFileMediaList) {
      buffer.writeln('    - ${xfile.path}');
    }

    return buffer.toString();
  }
}