import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_preview_screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/icon_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';

Widget bottomNavBar(Future<void> Function() saveDraft,
    Future<void> Function() updatePostStream) {
  var text = AppLocalizations.of(Get.context!);
  AddPostSysService addPostSysService = Get.find();

  return Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIconButton(
              icon: Icons.save,
              isLoading: addPostSysService.isLoading.value,
              onPressed: addPostSysService.isLoading.value
                  ? null
                  : () async {
                      await saveDraft();
                    },
            ),
            Obx(
              () => addPostSysService.post.value.content.content!.isEmpty
                  ? CustomIconButton(
                      icon: Icons.add,
                      onPressed: () {
                        Get.to(() => const AddSection());
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            CustomIconButton(
              icon: Icons.visibility,
              onPressed: () async {
                await updatePostStream();

                if (addPostSysService.isPostNotEmpty(showError: true)) {
                  Get.to(() => PostPreview(post: addPostSysService.post.value));
                } else {
                  showCustomSnackbar(
                    title: text!.alert,
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
