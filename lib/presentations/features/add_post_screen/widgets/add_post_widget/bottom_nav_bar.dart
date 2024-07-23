import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/validators/post_title_validator.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_preview_screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_section_sys_service.dart';
Widget bottomNavBar(Future<void> Function() saveDraft, {VoidCallback? updatePostStream}) {
  final colorScheme = Theme.of(Get.context!).colorScheme;
  var text = AppLocalizations.of(Get.context!);
  AddPostSysService addPostSysService = Get.find();
  AddSectionSysService addSectionSysService = Get.find();
  
  return Obx(() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconTextButton(
          icon: Icons.save,
          label: text!.save,
          isLoading: addPostSysService.isLoading.value,
          onPressed: () async {
            if (!addPostSysService.isLoading.value) {
              addPostSysService.isLoading.value = true;
              try {
                await saveDraft();
              } finally {
                addPostSysService.isLoading.value = false;
              }
            }
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
            updatePostStream?.call();
            if (isPostNotEmpty(addPostSysService.post.value)) {
              Get.to(() => PostPreview(post: addPostSysService.post.value!));
            } else {
              showCustomSnackbar(
                title: text.alert,
                message: text.nothingToShow,
                snackType: SnackType.warning,
              );
            }
          },
        ),
      ],
    ),
  ));
}

bool isPostNotEmpty(Post? post) {
  return post?.title != null &&
      PostTitleValidator.validate(post?.title) == null &&
      post!.title.isNotEmpty &&
      post.tags.isNotEmpty &&
      post.content.isNotEmpty &&
      post.headerImageIMG != null;
}