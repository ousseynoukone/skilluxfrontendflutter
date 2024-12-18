import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/add_media.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';

mixin ImagePickerMixin<T extends StatefulWidget> on State<T> {
  final Logger _logger = Logger();
  final picker = ImagePicker();
  XFile? pickedImage;

  Future<void> pickImage() async {
    try {
      final ImageSource? source = await _showImageSourceDialog();
      if (source != null) {
        final XFile? image = await picker.pickImage(source: source);
        if (image != null) {
          setState(() {
            String? mimeType = _getMimeTypeFromExtension(image.path);
            pickedImage = XFile(image.path,
                mimeType: mimeType ?? image.mimeType,
                name: image.name); // Create a new XFile instance
          });
        }
      }
    } catch (e) {
      _logger.d('Error picking image: ${e.toString()}');
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    var text = Get.context!.localizations;

    return showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text.chooseImageSource),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: Text(text.camera),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: Text(text.gallery),
            ),
          ],
        );
      },
    );
  }

  String? _getMimeTypeFromExtension(String path) {
    final extension = path.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'bmp':
        return 'image/bmp';
      case 'webp':
        return 'image/webp';
      default:
        return null;
    }
  }

  void deleteImage() {
    setState(() {
      pickedImage = null;
    });
  }

  Widget buildImageWidget(BuildContext context, String addMediaText) {
    if (pickedImage != null) {
      return Column(
        children: [
          const SizedBox(height: 7.3),
          displayImage(pickedImage!, deleteImage),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 20),
          addMediaWidget(
            addMediaText,
            pickImage,
            heightFactor: 10,
          ),
          const SizedBox(height: 11),
        ],
      );
    }
  }

  Widget displayPickedImage() {
    if (pickedImage != null) {
      Image image = getImageFromXfile(pickedImage!);

      return SizedBox(
        height: 200,
        width: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
