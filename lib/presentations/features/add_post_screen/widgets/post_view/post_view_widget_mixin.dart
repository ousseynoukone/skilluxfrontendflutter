import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/post_view/post_view_widget.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/widgets/sub_components/comment_component_for_notification.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen_foreign_profile.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen_home.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen_no_post_feed_controller.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment_field/comment_field.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/show_comment_input.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';

mixin PostViewWidgetMixin {
  // Quill controller initialization
  late QuillController controller;
  initQuillController(String? content) {
    controller = QuillController(
      readOnly: true,
      document: Document.fromJson(jsonDecode(content!)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  // Display like action button
  displayLike(
      {required bool allowCommentDiplaying, required PostViewWidget widget}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: widget.allowCommentDiplaying == true
          ? LikeWidget(
              isForPost: true,
              initialLikes: widget.post.votesNumber ?? 0,
              elementId: widget.post.id!,
              likeFunction:
                  getPostProvider(widget.commentPostProvider).likePost,
              unlikeFunction:
                  getPostProvider(widget.commentPostProvider).unLikePost,
            )
          : const SizedBox.shrink(),
    );
  }

  // Display comment input
  void showCommentField(int postId) {
    showCommentInput(CommentField(commentDTO: CommentDto(postId: (postId))));
  }

// Render the appropriate Comment Screen
  Widget comments(
      {required bool allowCommentDiplaying, required PostViewWidget widget}) {
    if (allowCommentDiplaying) {
      if (widget.commentPostProvider == CommentPostProvider.homePostService) {
        return CommentScreenHome(
          postId: widget.post.id!,
        );
      } else if (widget.commentPostProvider ==
          CommentPostProvider.foreignProfilePostService) {
        return CommentScreenForeignUser(
          postId: widget.post.id!,
        );
      } else if (widget.commentPostProvider ==
          CommentPostProvider.userProfilePostService) {
        return CommentScreen(
          postId: widget.post.id!,
        );
      } else {
        return CommentScreenNoHomePostService(
          postId: widget.post.id!,
        );
      }
    } else {
      if (widget.commentNotification != null) {
        return CommentComponentForNotification(
          commentNotification: widget.commentNotification,
        );
      }
    }

    return const SizedBox.shrink();
  }

// Handling Scrolling down on comment if needed

  double _maxScrollExtent = 0.0;
  Timer? _timer; // Timer to check max scroll extent periodically

  void initializeMaxScrollTimer(
      {required bool scrollToComment,
      required ScrollController scrollController}) {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      checkMaxScrollExtent(scrollToComment, scrollController);
    });
  }

  void cancelMaxScrollTimer() {
    _timer?.cancel(); // Cancel the timer
  }

  void checkMaxScrollExtent(
      bool scrollToComment, ScrollController scrollController) {
    double currentMaxScrollExtent = scrollController.position.maxScrollExtent;
    if (currentMaxScrollExtent != _maxScrollExtent) {
      _maxScrollExtent = currentMaxScrollExtent;
      if (scrollToComment) {
        // Scroll to the bottom
        scrollController.animateTo(
          currentMaxScrollExtent,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.ease,
        );
      }
    }
  }
}
