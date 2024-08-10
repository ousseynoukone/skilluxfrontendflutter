import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';

import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/add_post_services/controllers/add_post_controller.dart';

class PostPreview extends StatefulWidget {
  final Post post;
  const PostPreview({super.key, required this.post});

  @override
  State<PostPreview> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> with SectionBuilderMixin {
  final AddPostService _addPostService = Get.put(AddPostService());

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return Scaffold(
        appBar: AppBar(
          title: Text(text.preview),
        ),
        body: PostView(post: widget.post),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Center(
            child: Obx(
              () => IconTextButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                icon: Icons.publish,
                label: text.publish,
                isLoading: _addPostService.isLoading.value,
                onPressed: () async {
                  _addPostService.addPost(widget.post);
                },
              ),
            ),
          ),
        ));
  }
}
