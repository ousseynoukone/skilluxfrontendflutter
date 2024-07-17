import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            GestureDetector(
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
            width: constraints.maxWidth, // Use full width of parent
            child: AspectRatio(
              aspectRatio: 16 / 9, // You can adjust this ratio as needed
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(8), // Optional: for rounded corners
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: image,
                ),
              ),
            ),
          );
        });
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
