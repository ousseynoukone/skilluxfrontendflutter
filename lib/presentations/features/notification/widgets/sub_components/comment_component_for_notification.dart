import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/token_manager.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/comment_notification.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/helpers/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_update_service.dart';

class CommentComponentForNotification extends StatelessWidget {
  final CommentNotification? commentNotification;

  const CommentComponentForNotification({super.key, this.commentNotification});

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        CommentComponent(comment: commentNotification!.comment),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: viewOtherComment(text),
        )
      ]),
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
