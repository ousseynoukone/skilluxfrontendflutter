import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class BirthDateValidator {
  static String? validate(String? value) {
    final text = Get.context?.localizations;

    if (value == null || value.isEmpty) {
      return text?.enterBirth;
    }

    // Example validation: Check if the input matches either en format (YYYY-MM-DD) or fr format (DD-MM-YYYY)
    final RegExp enDateRegex = RegExp(
      r'^\d{4}-\d{2}-\d{2}$', // English format: YYYY-MM-DD
    );

    final RegExp frDateRegex = RegExp(
      r'^\d{2}-\d{2}-\d{4}$', // French format: DD-MM-YYYY
    );

    if (!enDateRegex.hasMatch(value) &&  !frDateRegex.hasMatch(value)) {
      return text?.birthRequirement;
    }

    return null; // Return null if the input is valid
  }
}