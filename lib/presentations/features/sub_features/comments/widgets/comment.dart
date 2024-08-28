import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';

class CommentComponent extends StatefulWidget {
  final Comment comment;
  const CommentComponent({super.key, required this.comment});

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    Widget bottomComment() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          displayTimeAgo(widget.comment.createdAt),
          LikeAndReplyWidget(
            initialLikes: widget.comment.like,
            onReplyPressed: () {},
          )
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: colorScheme.primary, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(
          widget.comment.username ?? widget.comment.fullName!,
          style: themeText.titleSmall,
        ),
        leading: displayUserPP(widget.comment.profilePicture, radius: 30),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.comment.text,
                style:
                    themeText.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
                maxLines: null,
              ),
            ),
            bottomComment()
          ],
        ),
      ),
    );
  }
}
