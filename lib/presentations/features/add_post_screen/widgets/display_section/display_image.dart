import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

/// Displays an image from an XFile with an optional delete button.
Widget displayImage(XFile pickedImage, VoidCallback onDelete,
    {bool isDraft = true}) {
  // Obtain image widget (cached for web, direct for mobile/desktop)
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
                borderRadius: BorderRadius.circular(8),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: image,
                ),
              ),
            );
          },
        );
}

/// Displays a cached image from a URL with loading and error handling.
Widget displayImageFromURL(String url) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
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
      ),
    ),
  );
}

/// Gets an image widget from an XFile, using caching for web.
Image getImageFromXfile(XFile pickedImage) {
  if (kIsWeb) {
    // Web: Use CachedNetworkImage for caching the network image
    return Image.network(
      pickedImage.path,
      fit: BoxFit.cover,
    );
  } else {
    // Mobile/Desktop: Use Image.file directly (no caching needed)
    return Image.file(
      File(pickedImage.path),
      fit: BoxFit.cover,
    );
  }
}
