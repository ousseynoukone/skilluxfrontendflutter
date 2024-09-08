import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/post_view/post_view_widget.dart';

import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/add_post_services/controllers/add_post_controller.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class PostView extends StatefulWidget {
  final Post post;
  final bool isForOther;
  const PostView({super.key, required this.post, this.isForOther = false});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with SectionBuilderMixin {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    final UserProfilePostService userProfilePostService = Get.find();

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButtonComponent(
            menuItems: [
              CustomPopupMenuItem(
                value: "deletePost",
                text: text.delete,
                icon: const Icon(Icons.delete, color: ColorsTheme.primary),
                onTap: () => Get.to(Get.dialog(ConfirmationDialog(
                    title: text.confirmation,
                    content: text.confirm,
                    onConfirm: () {
                      userProfilePostService.deletePost(widget.post.id!);
                    }))),
              ),
            ],
          )
        ],
      ),
      body: PostViewWidget(
        post: widget.post,
        allowCommentDiplaying: true,
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 60,
      //   child: widget.isForOther? const SizedBox.shrink() : Center(
      //     child: Obx(
      //       () => IconTextButton(
      //         padding:
      //             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      //         icon: Icons.delete,
      //         iconColor: ColorsTheme.primary,
      //         label: text.delete,
      //         isLoading: userProfilePostService.isLoading.value,
      //         onPressed: () {
      //           Get.dialog(ConfirmationDialog(
      //               title: text.confirmation,
      //               content: text.confirm,
      //               onConfirm: () {
      //                 userProfilePostService.deletePost(widget.post.id!);
      //               }));
      //         },
      //       ),
      //     ),
      //   ),
      // )
    );
  }
}
