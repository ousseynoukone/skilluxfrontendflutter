import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackType { info, warning, error, success }

void showCustomSnackbar({
  required String title,
  required String message,
  SnackType snackType = SnackType.info,
  SnackPosition snackPosition = SnackPosition.TOP,
  Duration duration = const Duration(seconds: 5),
  EdgeInsets margin = const EdgeInsets.all(10),
  EdgeInsets padding = const EdgeInsets.all(10),
}) {
  TextTheme textTheme = Get.context!.textTheme;

  IconData icon;
  Color iconColor;

  switch (snackType) {
    case SnackType.warning:
      icon = Icons.warning;
      iconColor = Colors.orange;
      break;
    case SnackType.error:
      icon = Icons.error;
      iconColor = Colors.red;
      break;
    case SnackType.success:
      icon = Icons.check_circle;
      iconColor = Colors.green;
      break;
    case SnackType.info:
    default:
      icon = Icons.info;
      iconColor = Colors.blue;
      break;
  }

  Get.snackbar(
    title,
    '',
    icon: Icon(icon, color: iconColor),
    snackPosition: snackPosition,
    duration: duration,
    margin: margin,
    padding: padding,
    borderRadius: 10,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    messageText: Text(
      message,
      style: textTheme.bodyMedium,
    ),
  );
}
