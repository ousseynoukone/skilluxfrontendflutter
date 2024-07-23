import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_ago_format.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/helper.dart';

class PostView extends StatefulWidget {
  final Post post;
  const PostView({super.key, required this.post});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with SectionBuilderMixin {
  User? user;
  final HiveUserPersistence _hiveUserPersistence = Get.find();
  late QuillController controller;

  Future<void> _getUser() async {
    user = await _hiveUserPersistence.readUser();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    controller = QuillController(
      document: Document.fromJson(jsonDecode(widget.post.content)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    displayTimeAgo() {
      return FutureBuilder<String>(
        future: getTimeAgo(widget.post.createdAt!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return Text(snapshot.data!, style: themeText.bodySmall);
          } else {
            return const Text('No data');
          }
        },
      );
    }

    Widget displayReadingTime() {
      int documentLength = controller.document.length;
      String plainText = controller.document.getPlainText(0, documentLength);
      String readingTimeMessage = getReadingTime(plainText);

      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.topLeft,
          child: getChip(readingTimeMessage, Icons.timer_outlined));
    }

    Widget displayPostMinimalAttribute() {
      return Column(
        children: [
          user != null
              ? displayUserPreview(user!, trailing: displayTimeAgo())
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
      return SingleChildScrollView(
        child: Column(
          children: [
            displayPostMinimalAttribute(),
            if (widget.post.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: sectionBuilderForViewAndPreview(),
              ),
          ],
        ),
      );
    }

    return displayPost();
  }
}
