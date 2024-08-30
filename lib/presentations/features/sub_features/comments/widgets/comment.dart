import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/delete_comment_button.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

class CommentComponent extends StatelessWidget {
  final Comment comment;

  const CommentComponent({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return GetX<CommentService>(
      builder: (controller) {
        var updatedComment = controller.comments
            .firstWhere((c) => c.id == comment.id, orElse: () => comment);

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              updatedComment.username ?? updatedComment.fullName!,
              style: themeText.titleSmall,
            ),
            leading: displayUserPP(updatedComment.profilePicture, radius: 30),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    updatedComment.text,
                    style: themeText.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.visible,
                    maxLines: null,
                  ),
                ),
                bottomComment(updatedComment, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomComment(Comment comment, BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayTimeAgoSync(comment.createdAt),
        LikeAndReplyWidget(
          initialLikes: comment.like,
          commentId: comment.id,
          onReplyPressed: () {},
        ),
        const SizedBox(width: 8),
        displayDeleteCommentButton(comment),
      ],
    );
  }
}
