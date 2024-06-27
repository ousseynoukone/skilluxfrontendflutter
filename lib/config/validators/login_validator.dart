import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class LoginValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.pleaseEnterLogin;
    }

    // Check if it's an email
    if (_isEmail(value)) {
      if (!_isValidEmail(value)) {
        return text?.emailRequirement;
      }
    } else {
      // Check if it's a valid username (custom validation logic)
      if (!_isValidUsername(value)) {
        return text?.usernameRequirement;
      }
    }

    return null; // Return null if the input is valid
  }

  static bool _isEmail(String value) {
    // Simple check for email format (contains '@')
    return value.contains('@');
  }

  static bool _isValidEmail(String value) {
    // More thorough email validation using regex and check for no capital letters
    final RegExp emailRegex = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(value) && !value.contains(RegExp(r'[A-Z]'));
  }

  static bool _isValidUsername(String value) {
    // Custom validation logic for username (e.g., minimum length and no capital letters)
    return value.length >= 3 && !value.contains(RegExp(r'[A-Z]'));
  }
}
