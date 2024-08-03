import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

Widget addMediaWidget(String text, VoidCallback onTap, {heightFactor = 6}) {
  final colorScheme = Theme.of(Get.context!).colorScheme;

  return InkWell(
    onTap: onTap,
    child: DottedBorder(
      color: colorScheme.onSecondary,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [12, 4], // Customize dash length and gap
      strokeWidth: 2,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.primaryContainer),
        height: Get.height / heightFactor,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Icon(Icons.add), Text(text)],
        ),
      ),
    ),
  );
}
