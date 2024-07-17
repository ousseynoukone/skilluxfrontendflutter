import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';

import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_section_sys_service.dart';
import '../../../../../config/theme/colors.dart';

class DisplaySection extends StatefulWidget {
  final Section section;
  final bool draftMode;
  final bool isPreview;
  final int index;

  const DisplaySection(
      {super.key,
      required this.section,
      this.draftMode = false,
      this.isPreview = false,
      required this.index});

  @override
  _DisplaySectionState createState() => _DisplaySectionState();
}

class _DisplaySectionState extends State<DisplaySection> {
  late QuillController _controller;
  AddSectionSysService addSectionSysService = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.section.content)),
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var text = context.localizations;
    var textTheme = context.textTheme;

    Widget _displayImage() {
      if (widget.draftMode && widget.section.image != null) {
        return SizedBox(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: widget.section.image,
          ),
        );
      } else if (widget.section.media != null &&
          widget.section.media!.isNotEmpty &&
          !widget.isPreview) {
        return Image.network(
          widget.section.media!,
          fit: BoxFit.cover,
          height: 150,
          width: 150,
        );
      }

      if (widget.isPreview && widget.section.image != null) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth, // Use full width of parent
            child: AspectRatio(
              aspectRatio: 16 / 9, // You can adjust this ratio as needed
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(8), // Optional: for rounded corners
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: widget.section.image,
                ),
              ),
            ),
          );
        });
      }
      return const SizedBox.shrink();
    }

    Widget _displayTitle() {
      if (widget.section.title != null) {
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12)),
            color: widget.draftMode
                ? colorScheme.onPrimary
                : colorScheme.onTertiary,
          ),
          child: Text(
            widget.section.title!,
            style: textTheme.headlineSmall,
          ),
        );
      }
      return const SizedBox.shrink();
    }

    Widget _displayDeleteSectionButton() {
      return Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.topRight,
          child: IconButton(
              color: ColorsTheme.primary,
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  addSectionSysService.removeSection(widget.index);
                });
              }));
    }

    Widget _displayIndex(int index) {
      return Container(
        alignment: Alignment.topRight,
        child: Chip(
          side: const BorderSide(color: ColorsTheme.tertiaryDarker),
          backgroundColor: colorScheme.primary,
          label: Text("${text.section} ${index + 1}",
              style: textTheme.bodySmall
                  ?.copyWith(color: colorScheme.onSecondary)),
        ),
      );
    }

    Widget _displayingSectionMangement() {
      return widget.draftMode
          ? Container(
              alignment: Alignment.topRight,
              child: Row(
                children: [
                  _displayIndex(widget.index),
                  _displayDeleteSectionButton(),
                ],
              ),
            )
          : const SizedBox.shrink();
    }

    Widget _displayContent() {
      if (widget.section.content.isNotEmpty) {
        // Set the controller to read-only mode
        _controller.readOnly = true;

        return Container(
          height: Get.height / 4,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: widget.draftMode
                ? colorScheme.onPrimary
                : colorScheme.onTertiary,
          ),
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
                textSelectionThemeData: Theme.of(context)
                    .textSelectionTheme
                    .copyWith(
                      selectionColor: ColorsTheme.secondary.withOpacity(0.3),
                    ),
                controller: _controller,
                padding: EdgeInsets.zero,
                autoFocus: false,
                expands: true,
                scrollable: true,
                showCursor: false,
                customStyles: DefaultStyles(
                    paragraph: DefaultTextBlockStyle(
                  textTheme.labelMedium!,
                  const VerticalSpacing(0, 0),
                  const VerticalSpacing(0, 0),
                  null,
                ))),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
            border: Border.all(color: colorScheme.onPrimary, width: 2)),
        child: Column(
          children: [
            _displayingSectionMangement(),
            // Display the image if available
            if (widget.section.media != null || widget.section.image != null)
              Container(
                height: Get.height / 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _displayImage(),
              ),
            const SizedBox(height: 16), // Add some spacing
            // QuillEditor content

            _displayTitle(),
            _displayContent()
          ],
        ),
      ),
    );
  }
}
