import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/comment_notification.dart';

import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/post_view/post_view_widget.dart';

import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';

import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class PostView extends StatefulWidget {
  final Post post;
  final CommentNotification? commentNotification;
  final bool allowCommentDiplaying;
  final bool ? scrollToComment;
  final CommentPostProvider commentPostProvider;
  const PostView(
      {super.key,
      required this.post,
      this.scrollToComment,
      required this.commentPostProvider,
      this.allowCommentDiplaying = true,
      this.commentNotification});

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
          widget.commentPostProvider ==
                  CommentPostProvider.userProfilePostService
              ? PopupMenuButtonComponent(
                  menuItems: [
                    CustomPopupMenuItem(
                      value: "deletePost",
                      text: text.delete,
                      icon:
                          const Icon(Icons.delete, color: ColorsTheme.primary),
                      onTap: () => Get.dialog(ConfirmationDialog(
                        title: text.confirmation,
                        content: text.confirm,
                        onConfirm: () {
                          userProfilePostService.deletePost(widget.post.id!);
                        },
                      )),
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
      body: PostViewWidget(
        commentPostProvider: widget.commentPostProvider,
        post: widget.post,
        allowCommentDiplaying: widget.allowCommentDiplaying,
        commentNotification: widget.commentNotification,
        scrollToComment: widget.scrollToComment ??  widget.commentNotification != null,
      ),
    );
  }
}
