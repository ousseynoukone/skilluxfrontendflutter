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
}
