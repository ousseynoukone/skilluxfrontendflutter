import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

Widget displayImage(XFile pickedImage, VoidCallback onDelete,
    {bool isDraft = true}) {
  Image image = getImageFromXfile(pickedImage);
  return isDraft
      ? Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image,
              ),
            ),
            InkWell(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: ColorsTheme.primary.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: const Icon(
                  Icons.close,
                  color: ColorsTheme.white,
                  size: 25,
                ),
              ),
            ),
          ],
        )
      : LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(8), // Optional: for rounded corners
              child: FittedBox(
                fit: BoxFit.contain,
                child: image,
              ),
            ),
          );
        });
}

Widget displayImageFromURL(String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          // Image has finished loading
          return child;
        } else {
          // While image is loading, show a circular progress indicator
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        // If there's an error loading the image, display a fallback widget
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(height: 8),
              Text(
                'Failed to load image',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Image getImageFromXfile(XFile pickedImage) {
  Image image;

  if (kIsWeb) {
    image = Image.network(pickedImage.path, fit: BoxFit.cover);
  } else {
    image = Image.file(File(pickedImage.path), fit: BoxFit.cover);
  }
  return image;
}
