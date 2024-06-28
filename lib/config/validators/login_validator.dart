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
    final RegExp emailRegex =
        RegExp(r"^[\s]*[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}[\s]*$");
    return emailRegex.hasMatch(value) && !value.contains(RegExp(r'[A-Z]'));
  }

  static bool _isValidUsername(String value) {
    // Custom validation logic for username (e.g., minimum length)
    // Check that the username is all lowercase, has at least 3 characters, and contains no spaces
    return value.length >= 3 &&
        _isAllLowercase(value) &&
        !_containsSpace(value);
  }

  static bool _isAllLowercase(String value) {
    return !value.contains(RegExp(r'[A-Z]'));
  }

  static bool _containsSpace(String value) {
    return value.contains(' ');
  }
}
