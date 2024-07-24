import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_section._screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_preview_screen.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skilluxfrontendflutter/services/system_services/add_post_sys_services/add_post_sys_service.dart';

Widget bottomNavBar(Future<void> Function() saveDraft,
    {VoidCallback? updatePostStream}) {
  var text = AppLocalizations.of(Get.context!);
  AddPostSysService addPostSysService = Get.find();

  return Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconTextButton(
              icon: Icons.save,
              label: text!.save,
              isLoading: addPostSysService.isLoading.value,
              onPressed: addPostSysService.isLoading.value
                  ? null
                  : () async {
                        await saveDraft();
                   
                    },
            ),
            Obx(
              () => addPostSysService.post.value.content.isEmpty
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
                // updatePostStream?.call();
                if (addPostSysService.isPostNotEmpty(showError: true)) {
                  Get.to(() => PostPreview(post: addPostSysService.post.value));
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
