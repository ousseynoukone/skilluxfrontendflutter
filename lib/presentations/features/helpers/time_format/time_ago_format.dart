import 'package:intl/intl.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';

Future<String> getTimeAgo(
  DateTime dateTime,
) async {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  var defaultLanguage = await defaultLangage();

  final l10n = _timeAgoLocalizations[defaultLanguage]!;

  if (difference.inSeconds < 30) {
    return l10n['now']!;
  } else if (difference.inMinutes < 1) {
    return l10n['lessThanAMinute']!;
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
    'minutes': '{0} minute ago',
    'hours': '{0} hour ago',
    'days': '{0} day ago',
    'weeks': '{0} week ago',
    'months': '{0} month ago',
    'years': '{0} year ago',
  },
  'fr': {
    'now': 'Maintenant',
    'lessThanAMinute': 'Il y a moins d\'une minute',
    'minutes': 'Il y a {0} minute',
    'hours': 'Il y a {0} heure',
    'days': 'Il y a {0} jour',
    'weeks': 'Il y a {0} semaine',
    'months': 'Il y a {0} mois',
    'years': 'Il y a {0} an',
  },
};
