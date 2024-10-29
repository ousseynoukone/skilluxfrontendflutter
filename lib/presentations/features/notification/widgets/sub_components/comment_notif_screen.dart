import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/comment_notification.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';

class CommentNotifScreen extends StatefulWidget {
  final Post? post;
  final int commentId;

  const CommentNotifScreen(
      {super.key, required this.post, required this.commentId});

  @override
  State<CommentNotifScreen> createState() => _CommentNotifScreenState();
}

class _CommentNotifScreenState extends State<CommentNotifScreen> {
  final CommentService commentService = Get.put(
      CommentService(commentPostProvider: CommentPostProvider.homePostService));
  Comment? comment;

  @override
  void initState() {
    super.initState();
    fetchComment();
  }

  Future<void> fetchComment() async {
    final fetchedComment =
        await commentService.getOneComment(commentId: widget.commentId);
    setState(() {
      comment = fetchedComment;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (comment == null || widget.post == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return PostView(
      post: widget.post!,
      allowCommentDiplaying: false,
      commentNotification: CommentNotification(post: widget.post!, comment: comment!),
      commentPostProvider: CommentPostProvider.uniquePostPostService,
    );
  }
}
