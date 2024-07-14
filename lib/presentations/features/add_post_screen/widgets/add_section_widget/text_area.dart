import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextArea extends StatelessWidget {
  const TextArea({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    QuillController _controller = QuillController.basic();

    return Column(
      children: [
        Container(
          height: Get.height / 2,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.onPrimary),
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              textSelectionThemeData: Theme.of(context)
                  .textSelectionTheme
                  .copyWith(
                      selectionColor: ColorsTheme.secondary.withOpacity(0.3)),
              controller: _controller,
              padding: EdgeInsets.zero,
              autoFocus: false,
              expands: true,
              scrollable: true,
            ),
          ),
        ),
        QuillToolbar.simple(
          configurations:
              QuillSimpleToolbarConfigurations(controller: _controller),
        ),
      ],
    );
  }
}
