import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_ago_format.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_format.dart';

displayTimeAgo(DateTime? createdAt, {double fontSize = 14}) {
  var themeText = Get.context!.textTheme;
  if (createdAt == null) {
    return const SizedBox.shrink();
  }
  return FutureBuilder<String>(
    future: getTimeAgo(createdAt),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        return Text(snapshot.data!,
            style: themeText.bodySmall?.copyWith(fontSize: fontSize));
      } else {
        return const Text('No data');
      }
    },
  );
}

displayTimeAgoSync(
  DateTime? createdAt, {
  double fontSize = 14,
}) {
  var themeText = Get.context!.textTheme;
  if (createdAt == null) {
    return const SizedBox.shrink();
  }

  return Text(getTimeAgoSync(createdAt),
      style: themeText.bodySmall?.copyWith(fontSize: fontSize));
}

displayDateTime(DateTime? createdAt, {double fontSize = 14}) {
  var themeText = Get.context!.textTheme;
  if (createdAt == null) {
    return const SizedBox.shrink();
  }
  return Text(formatDateTime(createdAt),
      style: themeText.bodySmall?.copyWith(fontSize: fontSize));
}
