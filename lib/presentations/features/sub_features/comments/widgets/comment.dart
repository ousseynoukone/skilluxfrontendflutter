import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment_actions_widget.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/delete_comment_button.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/show_comment_input.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/sub_comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

class CommentComponent extends StatelessWidget {
  final Comment comment;
  final bool displayReply;
  final bool isColorTransparent;
  final Logger _logger = Logger();

  CommentComponent({
    super.key,
    required this.comment,
    this.displayReply = true,
    this.isColorTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return GetX<CommentService>(
      builder: (controller) {
        var updatedComment = controller.comments.firstWhere(
          (c) => c.id == comment.id,
          orElse: () => comment,
        );

        return Container(
            decoration: BoxDecoration(
              color:
                  isColorTransparent ? Colors.transparent : colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile picture with a fixed radius
                  displayUserPP(updatedComment.user.profilePicture, radius: 30),

                  // Small gap between profile picture and text content
                  const SizedBox(width: 8),

                  // Column to hold user details and comment content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User details and comment text
                        ListTile(
                          contentPadding:
                              EdgeInsets.zero, // Remove default padding
                          title: Text(
                            '@${updatedComment.user.username}',
                            style: themeText.bodySmall?.copyWith(fontSize: 13),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              displayCommentText(updatedComment),
                              bottomComment(updatedComment),
                            ],
                          ),
                        ),

                        // Reply widget
                        displayReplyWidget(controller, updatedComment),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget displayCommentText(Comment updatedComment) {
    String targetUser = updatedComment.target?.username ?? "";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            if (targetUser.isNotEmpty)
              TextSpan(
                text: '@$targetUser ',
                style: Get.textTheme.headlineSmall?.copyWith(
                  fontSize: 14,
                  color: ColorsTheme
                      .secondary, // Change this to the desired color for the username
                ),
              ),
            TextSpan(
              text: updatedComment.text,
              style: Get.textTheme.headlineSmall?.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
        overflow: TextOverflow.visible,
        softWrap: true,
      ),
    );
  }

  Widget bottomComment(Comment updatedComment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayTimeAgoSync(updatedComment.createdAt),
        if (updatedComment.id != null)
          CommentActionsWidget(
            initialLikes: updatedComment.like,
            comment: updatedComment,
          ),
        const SizedBox(width: 8),
        displayDeleteCommentButton(updatedComment),
      ],
    );
  }

  Widget displayReplyWidget(
      CommentService commentService, Comment updatedComment) {
    if (!displayReply) {
      return const SizedBox.shrink();
    }

    return Obx(() {
      int descendantCount = commentService.comments
          .firstWhere((c) => c.id == updatedComment.id,
              orElse: () => updatedComment)
          .descendantCount;

      if (descendantCount > 0) {
        var themeText = Get.textTheme;
        var text = Get.context!.localizations;
        String label = descendantCount > 1 ? text.showReplies : text.showReply;

        return IconTextButton(
          icon: Icons.keyboard_arrow_up,
          textStyle: themeText.bodySmall,
          onPressed: () {
            showModalBottomSheet(
              context: Get.context!,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: GetBuilder<CommentService>(
                    builder: (controller) {
                      Comment latestComment = controller.comments.firstWhere(
                        (c) => c.id == updatedComment.id,
                        orElse: () => updatedComment,
                      );
                      return SubComment(comment: latestComment);
                    },
                  ),
                );
              },
            );
          },
          label: '$label ($descendantCount)',
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
