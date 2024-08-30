import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:logger/logger.dart';

class CommentScreen extends StatelessWidget {
  final int postId;
  final CommentService _commentService = Get.find();
  final Logger _logger = Logger();

  CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return GetBuilder<CommentService>(
      init: _commentService,
      initState: (_) {
        _commentService.getPostTopComments(postId);
      },
      builder: (controller) {
        if (controller.status.isLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: colorScheme.primaryContainer,
          ));
        } else if (controller.status.isEmpty) {
          return Center(
              child: Text(text.noComment, style: themeText.bodySmall));
        } else if (controller.status.isError) {
          return Center(
              child: Text(text.errorUnexpected, style: themeText.bodySmall));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.comments.length,
            itemBuilder: (context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CommentComponent(comment: controller.comments[index]),
              );
            },
          );
        }
      },
    );
  }
}
