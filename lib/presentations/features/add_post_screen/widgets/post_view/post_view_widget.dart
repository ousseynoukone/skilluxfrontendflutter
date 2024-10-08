import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:logger/logger.dart';

class PostViewWidget extends StatefulWidget {
  final Post post;
  const PostViewWidget({super.key, required this.post});

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget>
    with SectionBuilderMixin {
  User? user;
  final HiveUserPersistence _hiveUserPersistence = Get.find();
  late QuillController controller;
  final Logger _logger = Logger();

  Future<void> _getUser() async {
    user = await _hiveUserPersistence.readUser();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.post.content.content!)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

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
          user != null
              ? displayUserPreview(user!,
                  trailing: displayTimeAgo(widget.post.createdAt))
              : const CircularProgressIndicator(),
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

    Widget displayPost() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              displayPostMinimalAttribute(),
              if (widget.post.content.content!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: sectionBuilderForViewAndPreview(
                      quillController: controller),
                ),
            ],
          ),
        ),
      );
    }

    return displayPost();
  }
}
