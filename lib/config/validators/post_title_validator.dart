import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class PostTitleValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.postTitle;
    } else {
      if (value.length <= 1 || value.length >= 100) {
        return text?.postTitleRequirement;
      }
    }
    // Additional custom validation logic can be added here if needed
    return null; // Return null if the input is valid
  }
}
