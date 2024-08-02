import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_post_widget/add_media.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';

mixin ImagePickerMixin<T extends StatefulWidget> on State<T> {
  final Logger _logger = Logger();
  final picker = ImagePicker();
  XFile? pickedImage;

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          pickedImage = image;
         
        });
      }
    } catch (e) {
      _logger.d('Error picking image: ${e.toString()}');
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
}
