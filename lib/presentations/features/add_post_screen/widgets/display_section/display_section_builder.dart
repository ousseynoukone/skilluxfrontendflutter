import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/content_converter.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/add_section_widget/quillEditor.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';

mixin SectionBuilderMixin<T extends StatefulWidget> on State<T> {
  final AddPostSysService _addPostSysService = Get.find();

  Widget sectionBuilder({bool expanded = true}) {
    return Obx(() => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _addPostSysService.isContentEmpty()
            ? DisplaySection(
                content: _addPostSysService.post.value.content.content!,
                expanded: expanded)
            : const SizedBox.shrink()));
  }

  Widget sectionBuilderForViewAndPreview() {
    return Obx(() => sectionForViewAndPreview(
        _addPostSysService.post.value.content.content!));
  }

  Widget sectionForViewAndPreview(String content) {
    var colorScheme = Theme.of(context).colorScheme;

    QuillController controller = QuillController(
        document: DocumentConverter.convertToDocument(content) ?? Document(),
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Quilleditor(
        controller: controller,
        scrollable: false,
        bgColor: colorScheme.primaryFixed,
      ),
    );
  }
}
