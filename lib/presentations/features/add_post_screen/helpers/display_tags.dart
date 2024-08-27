import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget displayTags(List<String> tags) {
  // Retrieve localizations and text theme
  final textTheme = Theme.of(Get.context!).textTheme;
  final ColorScheme colorScheme = Theme.of(Get.context!).colorScheme;

  // Helper method to build each tag widget
  Widget tag(String tag) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      margin: const EdgeInsets.only(right: 4),
      child: Center(
        child: Text(
          '#$tag',
          style: textTheme.bodySmall
              ?.copyWith(fontSize: 12), // Apply the appropriate text style
        ),
      ),
    );
  }

  // Return SizedBox to provide a bounded height for ListView
  return ListView.builder(
    scrollDirection: Axis.horizontal, // Horizontal scroll for tags
    itemCount: tags.length,
    itemBuilder: (context, index) {
      return tag(tags[index]);
    },
  );
}
