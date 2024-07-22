import 'package:get/get.dart';
import 'package:reading_time/reading_time.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

String formatReadingTime(double doubleMinutes) {
  var text = Get.context!.localizations;
  var minutes = doubleMinutes.round();

  if (minutes < 1) {
    return text.lessThanOneMinuteRead;
  } else if (minutes == 1) {
    return text.oneMinuteRead;
  } else {
    return '$minutes ${text.minuteRead}';
  }
}

getReadingTime(String text) {
  var reader = readingTime(text);
  return formatReadingTime(reader.minutes);
}
