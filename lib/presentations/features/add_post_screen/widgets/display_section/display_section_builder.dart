import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section.dart';

Widget sectionBuilder(List<Section> section, {bool draftMode = true , bool isPreview = false}) {
  return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: section.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: DisplaySection(
              index: index,
              section: section[index],
              draftMode: draftMode,
              isPreview: isPreview,
            ));
      }));
}
