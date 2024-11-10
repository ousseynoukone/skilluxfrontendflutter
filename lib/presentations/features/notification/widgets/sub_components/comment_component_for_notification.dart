import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/comment_notification.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';

class CommentComponentForNotification extends StatelessWidget {
  final CommentNotification? commentNotification;

  const CommentComponentForNotification({super.key, this.commentNotification});

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var theme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Parent Comment
          CommentComponent(comment: commentNotification!.parentComment!),

          // Line Connector
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 4, bottom: 4),
            child: Row(
              children: [
                Container(
                  height: 24,
                  width: 2,
                  color: theme.primary.withOpacity(0.5),
                ),
                const SizedBox(width: 8),
                Text(
                  text.reply,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Child Comment
          Padding(
            padding: const EdgeInsets.only(left: 32.0), // Indentation for child
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: theme.surface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CommentComponent(comment: commentNotification!.comment),
            ),
          ),

          // View Other Comments Button
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: viewOtherComment(text),
          ),
        ],
      ),
    );
  }

  Widget viewOtherComment(var text) {
    return OutlineButtonComponent(
      onPressed: () {
        Get.off(() => PostView(
              post: commentNotification!.post,
              allowCommentDiplaying: true,
              commentPostProvider: CommentPostProvider.uniquePostPostService,
            ));
      },
      text: text.viewOtherComment,
      fullWidth: true,
      isLoading: false,
    );
  }
}
