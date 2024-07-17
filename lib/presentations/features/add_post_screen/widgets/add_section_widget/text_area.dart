import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextArea extends StatefulWidget {
  final QuillController controller;

  const TextArea({super.key, required this.controller});

  @override
  State<TextArea> createState() => _nameState();
}

class _nameState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        QuillToolbar.simple(
          configurations:
              QuillSimpleToolbarConfigurations(controller: widget.controller),
        ),
        Container(
          height: Get.height / 4,
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
              controller: widget.controller,
              padding: EdgeInsets.zero,
              autoFocus: false,
              expands: true,
              scrollable: true,
            ),
          ),
        ),
      ],
    );
  }
}
