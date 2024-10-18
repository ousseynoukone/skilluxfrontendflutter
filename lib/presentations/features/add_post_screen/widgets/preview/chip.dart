import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

Widget getCustomChip(
  String label,
  IconData? icon, {
  bool isBackgroundTransparent = false,
  double fontSize = 14,
  Color? backgroundColor,
  EdgeInsets? padding,
}) {
  final themeText = Get.context!.textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;

  return Container(
    padding: padding ?? EdgeInsets.symmetric(horizontal: isBackgroundTransparent ? 0 : 8.0, vertical: 4),
    decoration: BoxDecoration(
      color: backgroundColor ?? (isBackgroundTransparent ? Colors.transparent : colorScheme.primary),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: 16,
            color: ColorsTheme.secondary, // Adjust color as needed
          ),
        if (icon != null) const SizedBox(width: 4),
        Text(
          label,
          style: themeText.bodySmall?.copyWith(fontSize: fontSize, color: isBackgroundTransparent ? colorScheme.onPrimary : Colors.white),
        ),
      ],
    ),
  );
}
