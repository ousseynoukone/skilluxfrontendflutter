import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/helper.dart';

void showCommentInput(Widget widget,
    {bool hardenColor = false, String? targetUsername}) {
  var themeText = Get.context!.textTheme;
  var text = Get.context!.localizations;

  // Show BottomSheet modal
  showModalBottomSheet(
    context: Get.context!,
    barrierColor: hardenColor ? const Color.fromARGB(238, 16, 16, 16) : null,
    isScrollControlled: true, // Allow full screen when necessary
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Properly adjust for keyboard
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (targetUsername != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '${text.answerTo} @$targetUsername',
                  style: themeText.bodySmall?.copyWith(fontSize: 13),
                ),
              ),
            widget,
          ],
        ),
      );
    },
  );
}

