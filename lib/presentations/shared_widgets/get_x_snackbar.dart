import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  IconData icon = Icons.info,
  SnackPosition snackPosition = SnackPosition.TOP,
  Duration duration = const Duration(seconds: 3),
  EdgeInsets margin = const EdgeInsets.all(10),
  EdgeInsets padding = const EdgeInsets.all(10),
}) {
  Get.snackbar(
    title,
    message,
    icon: Icon(icon),
    snackPosition: snackPosition,
    duration: duration,
    margin: margin,
    padding: padding,
    borderRadius: 10,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
