import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_preview_screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_section_sys_service.dart';

Widget bottomNavBar(VoidCallback saveDraft, {VoidCallback? updatePostStream}) {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  var text = AppLocalizations.of(Get.context!);
  AddPostSysService addPostSysService = Get.find();
  AddSectionSysService addSectionSysService = Get.find();

  isPostNotEmpty() {
    var post = addPostSysService.post.value;
    if (post?.title != null &&
        post!.title.isNotEmpty &&
        post.tags.isNotEmpty &&
        post.content.isNotEmpty &&
        post.headerImageIMG != null) {
      return true;
    }
    return false;
  }

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
              // Update the post steam  before going to preview (in order to check if all field are not empty)
              updatePostStream!();

              if (isPostNotEmpty()) {
                Get.to(() => PostPreview(post: addPostSysService.post.value!));
              } else {
                showCustomSnackbar(
                  title: text!.alert,
                  message: text!.nothingToShow,
                  snackType: SnackType.warning,
                );
              }
            },
          ),
        ],
      ));
}
