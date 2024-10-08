import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class CommentScreenHome extends StatelessWidget {
  final int postId;
  final CommentService _commentService = Get.find();
  final PostFeedController  postFeedController = Get.find();

  final Logger _logger = Logger();

  CommentScreenHome({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    Widget commentHeaderBuilder() {
      return GetBuilder<PostFeedController>(
          init: postFeedController,
          initState: (_) {},
          builder: (controller) {
            var updatedPost = controller.recommendedPosts.firstWhereOrNull(
              (post) => post.id == postId,
            );

            if (updatedPost != null && updatedPost.commentNumber <= 0) {
              return Center(
                  child: Text(text.noComment, style: themeText.bodySmall));
            }

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
                          '(${updatedPost?.commentNumber})',
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
          });
    }

    return Column(
      children: [
        commentHeaderBuilder(),
        GetBuilder<CommentService>(
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
