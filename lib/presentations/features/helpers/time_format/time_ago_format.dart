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
    'lessThanAMinute': '-1 mn',
    'oneMinute': '1 mn',
    'minutes': '{0} mn',
    'hours': '{0} h',
    'days': '{0} d',
    'weeks': '{0} w',
    'months': '{0} mo',
    'years': '{0} y',
  },
  'fr': {
    'now': 'Maintenant',
    'lessThanAMinute': '-1 mn',
    'oneMinute': '1 mn',
    'minutes': '{0} mn',
    'hours': '{0} h',
    'days': '{0} j',
    'weeks': '{0} sem',
    'months': '{0} m',
    'years': '{0} an',
  },
};
