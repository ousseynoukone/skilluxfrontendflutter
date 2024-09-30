import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/comment_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment_field/comment_field.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/comment_repo.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class PostViewWidget extends StatefulWidget {
  final Post post;
  final bool allowCommentDiplaying;
  const PostViewWidget(
      {super.key, required this.post, this.allowCommentDiplaying = false});

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget>
    with SectionBuilderMixin {
  User? user;
  final HiveUserPersistence _hiveUserPersistence = Get.find();
  late QuillController controller;
  final Logger _logger = Logger();
  final ScrollController _scrollController = ScrollController();

  final CommentController _commentController = Get.put(CommentController());
  final CommentService _commentService = Get.put(CommentService());
  final UserProfileService _profileService = Get.find();

  void _getUser() {
    user = _profileService.user!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();

    controller = QuillController(
      readOnly: true,
      document: Document.fromJson(jsonDecode(widget.post.content.content!)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // We have reached the end of the list
      _commentService.loadMoreTopComments(widget.post.id!,
          disableLoading: true);
    }
  }

  void _showCommentField() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: Get.mediaQuery.viewInsets.bottom),
          child: CommentField(commentDTO: CommentDto(postId: (widget.post.id))),
        );
      },
    );
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
          displayUserPreview(user!,
              trailing: displayTimeAgo(widget.post.createdAt)),
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

    Widget comments() {
      return allowCommentDiplaying
          ? CommentScreen(
              postId: widget.post.id!,
            )
          : const SizedBox.shrink();
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
            comments()
          ],
        ),
        bottomNavigationBar:
            widget.allowCommentDiplaying ? bottomNavBar() : null,
      );
    }

    return displayPost();
  }
}
