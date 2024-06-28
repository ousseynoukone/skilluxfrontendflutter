import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class PasswordValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.enterYourPassword;
    }

    // Check if it matches the required pattern
    if (!_isValidPassword(value)) {
      return text?.passwordRequirements;
    }

    return null; // Return null if the input is valid
  }

  static bool _isValidPassword(String value) {
    // Password pattern regex (at least 8 characters, with at least one letter and one digit)
    final RegExp passwordRegex =
        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*()-_+=]{8,}$");

    return passwordRegex.hasMatch(value);
  }
}
