import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/delete_comment_button.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/sub_comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

class CommentComponent extends StatefulWidget {
  final Comment comment;
  final bool displayReply;
  final bool isColorTransparent;

  const CommentComponent(
      {super.key,
      required this.comment,
      this.displayReply = true,
      this.isColorTransparent = false});

  @override
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  late final Logger _logger;

  @override
  void initState() {
    super.initState();
    _logger = Logger();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    Widget displayCommentText(Comment updatedComment) {
      String targetUser = updatedComment.target?.username ?? "";
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          "${targetUser.isNotEmpty ? '@$targetUser ' : ''}${updatedComment.text}",
          style: themeText.headlineSmall?.copyWith(fontSize: 14),
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
      );
    }

    return GetX<CommentService>(
      builder: (controller) {
        var updatedComment = controller.comments.firstWhere(
            (c) => c.id == widget.comment.id,
            orElse: () => widget.comment);


        return Container(
          decoration: BoxDecoration(
            color: widget.isColorTransparent
                ? Colors.transparent
                : colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '@${updatedComment.user.username}',
                  style: themeText.bodySmall?.copyWith(fontSize: 13),
                ),
                leading: displayUserPP(updatedComment.user.profilePicture,
                    radius: 30),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    displayCommentText(updatedComment),
                    bottomComment(),
                  ],
                ),
              ),
              displayReply(controller, updatedComment, widget.displayReply)
            ],
          ),
        );
      },
    );
  }

  Widget displayReply(
      CommentService commentService, Comment comment, bool displayReply) {
    int descendantCount = comment.descendantCount;
    if (!displayReply) {
      return const SizedBox.shrink();
    }
    if (descendantCount > 0) {
      var themeText = Get.context!.textTheme;
      var text = Get.context!.localizations;
      String label = descendantCount > 1 ? text.showReplies : text.showReply;

      return IconTextButton(
        icon: Icons.keyboard_arrow_up,
        textStyle: themeText.bodySmall,
        onPressed: () {
          Get.bottomSheet(SubComment(comment: comment));
        },
        label: '$label (${comment.descendantCount})',
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget bottomComment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        displayTimeAgoSync(widget.comment.createdAt),
        LikeAndReplyWidget(
          initialLikes: widget.comment.like,
          commentId: widget.comment.id,
          onReplyPressed: () {
            // Handle reply action
          },
        ),
        const SizedBox(width: 8),
        displayDeleteCommentButton(widget.comment),
      ],
    );
  }
}
