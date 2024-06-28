import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class EmailValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.enterEmail;
    }

    // Check if it's an email

    if (!_isValidEmail(value)) {
      return text?.emailRequirement;
    }

    return null; // Return null if the input is valid
  }

  static bool _isValidEmail(String value) {
    // More thorough email validation using regex
final RegExp emailRegex =
    RegExp(r"^[\s]*[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}[\s]*$");
    return emailRegex.hasMatch(value) && !value.contains(RegExp(r'[A-Z]'));
  }
}
