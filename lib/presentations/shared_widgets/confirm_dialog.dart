import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog using GetX's Get.back()
          },
          child: Text(text.no),
        ),
        TextButton(
          onPressed: () {
            onConfirm(); // Perform the action
            Get.back(); // Close the dialog using GetX's Get.back()
          },
          child: Text(text.yes),
        ),
      ],
    );
  }
}
