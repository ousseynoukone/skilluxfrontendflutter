import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_preview_screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_section_sys_service.dart';

Widget bottomNavBar(VoidCallback saveDraft) {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  var text = AppLocalizations.of(Get.context!);
  AddPostSysService addPostSysService = Get.find();
  AddSectionSysService addSectionSysService = Get.find();

  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconTextButton(
            icon: Icons.save,
            label: text!.save,
            onPressed: () {
              saveDraft();
            },
          ),
          Obx(
            () => addSectionSysService.content.value.isEmpty
                ? IconTextButton(
                    icon: Icons.add,
                    label: text.addSection,
                    onPressed: () {
                      Get.to(() => const AddSection());
                    },
                  )
                : const SizedBox.shrink(),
          ),
          IconTextButton(
            icon: Icons.visibility,
            label: text.preview,
            onPressed: () {
              if (addPostSysService.post.value != null) {
                Get.to(() => PostPreview(post: addPostSysService.post.value!));
              }
            },
          ),
        ],
      ));
}
