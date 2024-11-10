import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/post_service.dart';

class CommentScreenNoHomePostService extends StatefulWidget {
  final int postId;

  const CommentScreenNoHomePostService({super.key, required this.postId});

  @override
  _CommentScreenHomeState createState() => _CommentScreenHomeState();
}

class _CommentScreenHomeState extends State<CommentScreenNoHomePostService> {
  final CommentService _commentService = Get.find();
  PostService postService = Get.find();
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();

    // Load the top comments when the widget is initialized
    _commentService.getPostTopComments(widget.postId);
    // Get Current Post Information
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    Widget commentHeaderBuilder() {
      return Obx(() {
        Post? post = postService.post.value;
        int commentNumber = post?.commentNumber ?? 0;
        if (commentNumber == 0) {
          return Center(
              child: Text(text.noComment, style: themeText.bodySmall));
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        text.comments,
                        style: themeText.titleSmall,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${post!.commentNumber})',
                        style: themeText.bodySmall,
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Divider(
                        thickness: 0.2,
                      )),
                ],
              ),
            ],
          );
        }
      });
    }

    return Column(
      children: [
        commentHeaderBuilder(),
        GetBuilder<CommentService>(
          init: _commentService,
          builder: (controller) {
            if (controller.status.isLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: colorScheme.primaryContainer,
              ));
            } else if (controller.status.isError) {
              return Center(
                  child:
                      Text(text.errorUnexpected, style: themeText.bodySmall));
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.comments.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child:
                        CommentComponent(comment: controller.comments[index]),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
