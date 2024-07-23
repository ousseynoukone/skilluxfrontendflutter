import 'package:flutter/material.dart';

import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';

import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';

class PostPreview extends StatefulWidget {
  final Post post;
  const PostPreview({super.key, required this.post});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> with SectionBuilderMixin {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(text.preview),
      ),
      body: PostView(post: widget.post),
    );
  }
}
