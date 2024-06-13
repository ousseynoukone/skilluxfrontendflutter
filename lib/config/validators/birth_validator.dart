import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class BirthDateValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.enterBirth;
    }
    // Example validation: Check if the input matches a date format
    final RegExp dateRegex = RegExp(
      r'^\d{4}-\d{2}-\d{2}$', // Example: YYYY-MM-DD
    );
    if (!dateRegex.hasMatch(value)) {
      return text?.birthRequirement;
    }
    // Additional custom validation logic can be added here if needed
    return null; // Return null if the input is valid
  }
}
