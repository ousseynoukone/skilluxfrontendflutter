import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';

class PostPreview extends StatefulWidget {
  final Post post;
  const PostPreview({super.key, required this.post});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;

    Widget displayTitle() {
      return Text(widget.post.title, style: themeText.titleMedium);
    }

    Widget _displayPost() {
      return SingleChildScrollView(
        child: Column(
          children: [
            displayTitle(),
            if (widget.post.headerImageIMG != null)
              displayImage(widget.post.headerImageIMG!, () {}, isDraft: false),
            if (widget.post.sections != null)
              sectionBuilder(widget.post.sections!,
                  draftMode: false, isPreview: true)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(text.preview),
      ),
      body: _displayPost(),
    );
  }
}
