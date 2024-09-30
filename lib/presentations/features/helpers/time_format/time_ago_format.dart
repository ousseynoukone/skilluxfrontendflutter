import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

Future<String> getTimeAgo(DateTime dateTime) async {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  var defaultLanguage = await defaultLangage();

  final l10n = _timeAgoLocalizations[defaultLanguage]!;

  if (difference.inSeconds < 30) {
    return l10n['now']!;
  } else if (difference.inMinutes < 1) {
    return l10n['lessThanAMinute']!;
  } else if (difference.inMinutes == 1) {
    return l10n['oneMinute']!;
  } else if (difference.inMinutes < 60) {
    return _format(l10n['minutes']!, difference.inMinutes);
  } else if (difference.inHours < 24) {
    return _format(l10n['hours']!, difference.inHours);
  } else if (difference.inDays < 7) {
    return _format(l10n['days']!, difference.inDays);
  } else if (difference.inDays < 30) {
    return _format(l10n['weeks']!, (difference.inDays / 7).floor());
  } else if (difference.inDays < 365) {
    return _format(l10n['months']!, (difference.inDays / 30).floor());
  } else {
    return _format(l10n['years']!, (difference.inDays / 365).floor());
  }
}

String getTimeAgoSync(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  UserProfileService userProfileService = Get.find();
  var defaultLanguage = userProfileService.user!.lang;

  final l10n = _timeAgoLocalizations[defaultLanguage]!;

  if (difference.inSeconds < 30) {
    return l10n['now']!;
  } else if (difference.inMinutes < 1) {
    return l10n['lessThanAMinute']!;
  } else if (difference.inMinutes == 1) {
    return l10n['oneMinute']!;
  } else if (difference.inMinutes < 60) {
    return _format(l10n['minutes']!, difference.inMinutes);
  } else if (difference.inHours < 24) {
    return _format(l10n['hours']!, difference.inHours);
  } else if (difference.inDays < 7) {
    return _format(l10n['days']!, difference.inDays);
  } else if (difference.inDays < 30) {
    return _format(l10n['weeks']!, (difference.inDays / 7).floor());
  } else if (difference.inDays < 365) {
    return _format(l10n['months']!, (difference.inDays / 30).floor());
  } else {
    return _format(l10n['years']!, (difference.inDays / 365).floor());
  }
}

String _format(String template, int value) {
  return template.replaceAll('{0}', value.toString());
}

final _timeAgoLocalizations = {
  'en': {
    'now': 'Now',
    'lessThanAMinute': 'Less than a minute ago',
    'oneMinute': '1 minute ago',
    'minutes': '{0} minutes ago',
    'hours': '{0} hours ago',
    'days': '{0} days ago',
    'weeks': '{0} weeks ago',
    'months': '{0} months ago',
    'years': '{0} years ago',
  },
  'fr': {
    'now': 'Maintenant',
    'lessThanAMinute': 'Il y a moins d\'une minute',
    'oneMinute': 'Il y a 1 minute',
    'minutes': 'Il y a {0} minutes',
    'hours': 'Il y a {0} heures',
    'days': 'Il y a {0} jours',
    'weeks': 'Il y a {0} semaines',
    'months': 'Il y a {0} mois',
    'years': 'Il y a {0} ans',
  },
};
