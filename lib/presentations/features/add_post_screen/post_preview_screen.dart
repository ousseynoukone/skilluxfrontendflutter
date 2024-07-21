import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/utils/hive_local_storage.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';

class PostPreview extends StatefulWidget {
  final Post post;
  const PostPreview({super.key, required this.post});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> with SectionBuilderMixin {
  User? user;
  final HiveUserPersistence _hiveUserPersistence = Get.find();

  Future<void> _getUser() async {
    user = await _hiveUserPersistence.readUser();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    Widget displayPostMinimalAttribute() {
      return Column(
        children: [
          user != null
              ? displayUserPreview(user!)
              : const CircularProgressIndicator(),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(widget.post.title, style: themeText.headlineMedium),
          ),
          if (widget.post.headerImageIMG != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: displayImage(widget.post.headerImageIMG!, () {},
                  isDraft: false),
            ),
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
              )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(text.preview),
      ),
      body: displayPost(),
    );
  }
}
