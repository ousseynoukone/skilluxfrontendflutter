import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime? dateTime) {
  BuildContext context = Get.context!;
  if (dateTime == null) {
    return 'Date unknown';
  }

  final locale = Localizations.localeOf(context).languageCode;

  if (locale == 'fr') {
    // French format: dd/MM/yyyy à HH:mm
    return DateFormat("dd/MM/yyyy 'à' HH:mm", 'fr_FR').format(dateTime);
  } else {
    // Default to English format: MM/dd/yyyy at hh:mm a
    return DateFormat("MM/dd/yyyy 'at' h:mm a", 'en_US').format(dateTime);
  }
}
