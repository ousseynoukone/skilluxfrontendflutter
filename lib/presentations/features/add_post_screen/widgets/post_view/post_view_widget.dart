import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/comment_notification.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/post_view/post_view_widget_mixin.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';

import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

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
    with SectionBuilderMixin, PostViewWidgetMixin {
  // ignore: prefer_typing_uninitialized_variables
  var user;

  final UserProfileService _userProfileService = Get.find();
  final Logger _logger = Logger();
  final ScrollController _scrollController = ScrollController();
  late final CommentService _commentService;

  @override
  void initState() {
    super.initState();
    _getUser();
    //  Init Comment Service
    _commentService = Get.put(
        CommentService(commentPostProvider: widget.commentPostProvider));

    initQuillController(widget.post.content.content!);
    _scrollController.addListener(_scrollListener);
    // Initialize the timer
    initializeMaxScrollTimer(
        scrollToComment: widget.scrollToComment,
        scrollController: _scrollController);
  }

  @override
  void dispose() {
    cancelMaxScrollTimer(); // Cancel the timer
    super.dispose();
  }

//  Get the user information
  void _getUser() {
    // IF THIS IS CALLED FROM HOME SCREEN USER INFORMATION SHOULD BE THE ONE WITHIN THE POST
    user =
        widget.commentPostProvider == CommentPostProvider.userProfilePostService
            ? _userProfileService.user
            : widget.post.user;
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
    // If the user scroll by itself , no need to scroll down anymore
    cancelMaxScrollTimer();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    bool allowCommentDiplaying = widget.allowCommentDiplaying;

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
          Row(
            children: [
              displayReadingTime(),
              displayLike(
                  allowCommentDiplaying: widget.allowCommentDiplaying,
                  widget: widget)
            ],
          )
        ],
      );
    }

    Widget bottomNavBar() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: InkWell(
          onTap: () {
            showCommentField(widget.post.id!);
          },
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

    Widget displayPost() {
      return Scaffold(
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          controller: _scrollController,
          children: [
            displayPostMinimalAttribute(),
            if (widget.post.content.content!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: sectionBuilderForViewAndPreview(
                    quillController: controller),
              ),
            comments(
                allowCommentDiplaying: allowCommentDiplaying, widget: widget),
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
