import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/comment_notification.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/widgets/sub_components/comment_component_for_notification.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen_foreign_profile.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen_home.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment_field/comment_field.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/show_comment_input.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/button.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

import '../../../sub_features/comments/comment_screen_no_post_feed_controller.dart';

class PostViewWidget extends StatefulWidget {
  final Post post;
  final CommentNotification? commentNotification;
  final bool allowCommentDiplaying;
  final bool scrollToComment;
  final CommentPostProvider commentPostProvider;

  const PostViewWidget(
      {super.key,
      required this.post,
      this.allowCommentDiplaying = false,
      this.commentNotification,
      required this.commentPostProvider,
      this.scrollToComment = false});

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget>
    with SectionBuilderMixin {
  // ignore: prefer_typing_uninitialized_variables
  var user;

  final UserProfileService _userProfileService = Get.find();
  late QuillController controller;
  final Logger _logger = Logger();
  final ScrollController _scrollController = ScrollController();
  late final CommentService _commentService;
  final commentKey = GlobalKey();

//  Get the user information
  void _getUser() {
    // IF THIS IS CALLED FROM HOME SCREEN USER INFORMATION SHOULD BE THE ONE WITHIN THE POST
    user =
        widget.commentPostProvider == CommentPostProvider.userProfilePostService
            ? _userProfileService.user
            : widget.post.user;
  }

  @override
  void initState() {
    super.initState();
    _getUser();

    _commentService = Get.put(
        CommentService(commentPostProvider: widget.commentPostProvider));

    controller = QuillController(
      readOnly: true,
      document: Document.fromJson(jsonDecode(widget.post.content.content!)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _scrollController.addListener(_scrollListener);
  }

// To load more Top comment
  void _scrollListener() {
    if (widget.allowCommentDiplaying &&
        _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _commentService.loadMoreTopComments(widget.post.id!,
          disableLoading: true);
    }
  }

// Display comment input
  void _showCommentField() {
    showCommentInput(
        CommentField(commentDTO: CommentDto(postId: (widget.post.id))));
  }

// Scroll to comment
  scrollToComment() {
    if (widget.scrollToComment) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final context = commentKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          );
        } else {
          _logger.d(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    bool allowCommentDiplaying = widget.allowCommentDiplaying;

    scrollToComment();

    Widget displayReadingTime() {
      int documentLength = controller.document.length;
      String plainText = controller.document.getPlainText(0, documentLength);
      String readingTimeMessage = getReadingTime(plainText);

      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.topLeft,
          child: getCustomChip(readingTimeMessage, Icons.timer_outlined,
              isBackgroundTransparent: true));
    }

    Widget displayPostMinimalAttribute() {
      return Column(
        children: [
          InkWell(
            onTap: () {
              if (widget.commentPostProvider !=
                  CommentPostProvider.userProfilePostService) {
                Get.to(() => ForeignProfileScreen(
                      foreignUserId: widget.post.userId!,
                      switchPostProviderOnCommentService: true,
                    ));
              }
            },
            child: displayUserPreview(user!,
                trailing: displayTimeAgo(widget.post.createdAt)),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(widget.post.title, style: themeText.headlineMedium),
          ),
          if (widget.post.headerImageIMG != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: displayImage(widget.post.headerImageIMG!, () {},
                  isDraft: false),
            ),
          if (widget.post.headerImageUrl != null &&
              widget.post.headerImageUrl!.isNotEmpty)
            displayImageFromURL(widget.post.headerImageUrl!),
          displayReadingTime()
        ],
      );
    }

    Widget bottomNavBar() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: InkWell(
          onTap: _showCommentField,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorScheme.primary),
            child: Center(child: Text(text.makeComment)),
          ),
        ),
      );
    }

// Render the appropriate Comment Screen
    Widget comments() {
      if (allowCommentDiplaying) {
        if (widget.commentPostProvider == CommentPostProvider.homePostService) {
          return CommentScreenHome(
            key: commentKey,
            postId: widget.post.id!,
          );
        } else if (widget.commentPostProvider ==
            CommentPostProvider.foreignProfilePostService) {
          return CommentScreenForeignUser(
            key: commentKey,
            postId: widget.post.id!,
          );
        } else if (widget.commentPostProvider ==
            CommentPostProvider.userProfilePostService) {
          return CommentScreen(
            key: commentKey,
            postId: widget.post.id!,
          );
        } else {
          return CommentScreenNoHomePostService(
            key: commentKey,
            postId: widget.post.id!,
          );
        }
      } else {
        if (widget.commentNotification != null) {
          return CommentComponentForNotification(
            key: commentKey,
            commentNotification: widget.commentNotification,
          );
        }
      }

      return const SizedBox.shrink();
    }

    Widget likeAndComment() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: allowCommentDiplaying == true
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
          ),
          comments(),
        ],
      );
    }

    Widget displayPost() {
      return Scaffold(
        body: ListView(
          controller: _scrollController,
          children: [
            displayPostMinimalAttribute(),
            if (widget.post.content.content!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: sectionBuilderForViewAndPreview(
                    quillController: controller),
              ),
            likeAndComment(),
          ],
        ),
        bottomNavigationBar: widget.allowCommentDiplaying
            ? SafeArea(child: bottomNavBar())
            : null,
      );
    }

    return displayPost();
  }
}
