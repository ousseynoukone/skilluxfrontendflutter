import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

Widget getCustomChip(String label, IconData? icon,
    {bool isBackgroundTransparent = false}) {
  var themeText = Get.context!.textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;
  double horizontal = isBackgroundTransparent ? 0 : 8.0;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 4),
    decoration: BoxDecoration(
      color: isBackgroundTransparent ? Colors.transparent : colorScheme.primary,
      // border: Border.all(color: colorScheme.primaryFixed, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) // Render icon only if it's not null
          Icon(
            icon,
            size: 16,
            color: ColorsTheme.secondary, // Adjust color as needed
          ),
        if (icon != null) const SizedBox(width: 4),
        Text(
          label,
          style: themeText
              .bodySmall, // Optional: Use text theme or customize as needed
        ),
      ],
    ),
  );
}
