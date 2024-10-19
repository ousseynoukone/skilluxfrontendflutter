import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime? dateTime, {bool showHourMinute = true}) {
  BuildContext context = Get.context!;
  if (dateTime == null) {
    return 'Date unknown';
  }

  final locale = Localizations.localeOf(context).languageCode;

  String formattedDate;
  if (locale == 'fr') {
    // French format: dd/MM/yyyy
    formattedDate = DateFormat("dd/MM/yyyy", 'fr_FR').format(dateTime);
    if (showHourMinute) {
      formattedDate += " à ${DateFormat("HH:mm", 'fr_FR').format(dateTime)}";
    }
  } else {
    // Default to English format: MM/dd/yyyy
    formattedDate = DateFormat("MM/dd/yyyy", 'en_US').format(dateTime);
    if (showHourMinute) {
      formattedDate += " at ${DateFormat("h:mm a", 'en_US').format(dateTime)}";
    }
  }

  return formattedDate;
}

String formatDateTimeHumanReadable(DateTime? dateTime, {bool showHour = true}) {
  BuildContext context = Get.context!;
  if (dateTime == null) {
    return 'Date unknown';
  }

  final locale = Localizations.localeOf(context).languageCode;
  final DateFormat dateFormat = locale == 'fr'
      ? DateFormat("EEEE, d MMMM yyyy", 'fr_FR')
      : DateFormat("EEEE, MMMM d, yyyy", 'en_US');

  final String datePart = dateFormat.format(dateTime);
  String result = locale == 'fr' ? "Le $datePart" : "On $datePart";

  if (showHour) {
    final String timePart = DateFormat("h:mm a", locale).format(dateTime);
    result += locale == 'fr' ? " à $timePart" : " at $timePart";
  }

  return result;
}
