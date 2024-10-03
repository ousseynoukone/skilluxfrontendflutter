import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/reply.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

class CommentActionsWidget extends StatelessWidget {
  final Comment comment;
  final int initialLikes;

  CommentActionsWidget({
    super.key,
    required this.comment,
    required this.initialLikes,
  });

  final CommentService _commentService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LikeWidget(
          initialLikes: initialLikes,
          elementId: comment.id!,
          likeFunction: _commentService.likeComment,
          unlikeFunction: _commentService.unLikeComment,
        ),
        const SizedBox(width: 16),
        ReplyButton(comment:comment),
      ],
    );
  }
}
