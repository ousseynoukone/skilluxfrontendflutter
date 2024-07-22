import 'package:intl/intl.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';

Future<String> getTimeAgo(DateTime dateTime,) async {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  var defaultLanguage = await defaultLangage();

  final l10n = 
      _timeAgoLocalizations[defaultLanguage]!;

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
    'minutes': '{0} minute{0:p:s} ago',
    'hours': '{0} hour{0:p:s} ago',
    'days': '{0} day{0:p:s} ago',
    'weeks': '{0} week{0:p:s} ago',
    'months': '{0} month{0:p:s} ago',
    'years': '{0} year{0:p:s} ago',
  },
  'fr': {
    'now': 'Maintenant',
    'lessThanAMinute': 'Il y a moins d\'une minute',
    'minutes': 'Il y a {0} minute{0:p:s}',
    'hours': 'Il y a {0} heure{0:p:s}',
    'days': 'Il y a {0} jour{0:p:s}',
    'weeks': 'Il y a {0} semaine{0:p:s}',
    'months': 'Il y a {0} mois',
    'years': 'Il y a {0} an{0:p:s}',
  },
};
