import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/quillEditor.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import '../../../../../config/theme/colors.dart';

class DisplaySection extends StatefulWidget {
  final String content;
  final bool expanded;

  const DisplaySection(
      {super.key, required this.content, this.expanded = true});

  @override
  _DisplaySectionState createState() => _DisplaySectionState();
}

class _DisplaySectionState extends State<DisplaySection> {
  late QuillController _controller;
  final AddPostSysService _addPostSysService = Get.find();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(DisplaySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.content != oldWidget.content) {
      _initializeController();
    }
  }

  void _initializeController() {
    _controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.content)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var text = context.localizations;

    Widget displayDeleteSectionButton() {
      return Container(
          
          padding: const EdgeInsets.only(top: 8),
          alignment: Alignment.topRight,
          child: IconTextButton(
              icon: Icons.delete,
              iconColor: ColorsTheme.primary,
              label: text.delete,
              onPressed: () {
                setState(() {
                  _addPostSysService.clearContent();
                });
              }));
    }

    Widget displayEditSectionButton() {
      return Container(
          padding: const EdgeInsets.only(top: 8, left: 8),
          alignment: Alignment.topRight,
          child: IconTextButton(
              label: text.edit,
              iconColor: ColorsTheme.secondary,
              icon: Icons.edit,
              onPressed: () {
                Get.to(() => const AddSection(editMode: true));
              }));
    }

    Widget displayingSectionMangement() {
      return Container(
        alignment: Alignment.topRight,
        child: Row(
          children: [displayDeleteSectionButton(), displayEditSectionButton()],
        ),
      );
    }

    Widget displayContent() {
      if (widget.content.isNotEmpty) {
        // Set the controller to read-only mode
        _controller.readOnly = true;

        return Container(
          height: Get.height / 2,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Quilleditor(
              controller: _controller,
              displayMode: true,
              expanded: widget.expanded),
        );
      }
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
          color: colorScheme
              .primaryContainer, // You can change this color as needed
          width: 1.0, // You can adjust the border width
          style: BorderStyle.solid,
        )),
        child: Column(
          children: [
            displayingSectionMangement(),
            const SizedBox(height: 8),
            displayContent()
          ],
        ),
      ),
    );
  }
}
