import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

Widget getChip(String label, IconData? icon) {
  var themeText = Get.context!.textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;

  return Chip(
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) // Render icon only if it's not null
          Icon(
            icon,
            size: 16,
            color: ColorsTheme.secondary, // Adjust color as needed
          ),
        const SizedBox(width: 4),
        Text(
          label,
          style: themeText
              .bodySmall, // Optional: Use text theme or customize as needed
        ),
      ],
    ),
    backgroundColor: colorScheme.primary, // Light blue background
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
      side: BorderSide(color: colorScheme.primary), // Light border
    ),
  );
}
