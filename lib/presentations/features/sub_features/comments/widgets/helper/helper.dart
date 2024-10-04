import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_service.dart';

String formatLikes(int likes) {
  // Get user's language preference if not provided
  UserProfileService userProfileService = Get.find();
  String lang = userProfileService.user!.lang!;

  // Define translation map
  Map<String, Map<String, String>> translations = {
    'en': {'thousand': 'K', 'million': 'M', 'billion': 'B'},
    'fr': {'thousand': 'K', 'million': 'M', 'billion': 'Mrd'}
  };

  // Use English as fallback if language is not supported
  Map<String, String> t = translations[lang] ?? translations['en']!;

  if (likes >= 1000000000) {
    double billions = likes / 1000000000;
    return '${billions.toStringAsFixed(1)}${t['billion']}';
  } else if (likes >= 1000000) {
    double millions = likes / 1000000;
    return '${millions.toStringAsFixed(1)}${t['million']}';
  } else if (likes >= 1000) {
    double thousands = likes / 1000;
    return '${thousands.toStringAsFixed(1)}${t['thousand']}';
  } else {
    return likes.toString();
  }
}

Future<bool> isElementAlreadyLiked(int elementId,
    {required bool isForPost}) async {
  final UserService userService = Get.find();
  List<int> ids = await userService.getUserLikesId(isForPost: isForPost);
  return ids.any((id) => id == elementId);
}
