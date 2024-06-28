import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class AuthHelper {
  static bool isUsername(String login) {
    // Regular expression to match an email address
    RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    // Check if the login matches the email regex
    if (emailRegex.hasMatch(login)) {
      return false; // It's an email
    }

    return true; // It's a simple username
  }

  static String formatBirthDate(String inputDate) {
    String currentLocale = Get.context?.localizations.localeName ??"";

    // Check if current locale is French
    if (currentLocale == 'fr') {
      List<String> dateParts = inputDate.trim().split('-');

      // Ensure dateParts contains three parts (day, month, year)
      if (dateParts.length == 3) {
        String formattedDate =
            '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
        return formattedDate;
      } else {
        // Handle invalid date format here
        throw FormatException('Invalid date format');
      }
    } else {
      return inputDate
          .trim(); // No need to change format for non-French locales
    }
  }
}
