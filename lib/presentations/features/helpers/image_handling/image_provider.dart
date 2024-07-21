// !!!!!!!!!!!! NOT USED FOR NOW !!!!!!!!!!!!!!!!!!!

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill_extensions/models/config/image/editor/image_configurations.dart';

QuillEditorImageEmbedConfigurations getImageEmbedConfiguration() {
  return QuillEditorImageEmbedConfigurations(
    imageProviderBuilder: (BuildContext context, String imageUrl) {
      if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
        return NetworkImage(imageUrl);
      } else {
        final file = File(imageUrl);
        if (file.existsSync()) {
          return FileImage(file);
        } else {
          return AssetImage(imageUrl);
        }
      }
    },
    imageErrorWidgetBuilder: (context, error, stackTrace) {
      return const Center(child: Text('Failed to load image'));
    },
  );
}
