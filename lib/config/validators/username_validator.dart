import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class UsernameValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.enterUsername;
    }

    if (!_isValidUsername(value)) {
      return text?.usernameRequirement;
    }

    return null; // Return null if the input is valid
  }

  static bool _isValidUsername(String value) {
    // Custom validation logic for username (e.g., minimum length)
    return value.length >= 3;
  }
}
