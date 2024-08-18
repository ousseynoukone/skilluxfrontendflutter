import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';

import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/post_view/post_view_widget.dart';

import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_section_builder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/text_button.dart';
import 'package:skilluxfrontendflutter/services/add_post_services/controllers/add_post_controller.dart';

class PostView extends StatefulWidget {
  final Post post;
  const PostView({super.key, required this.post});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> with SectionBuilderMixin {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return Scaffold(
      appBar: AppBar(
        actions: [
          //       PopupMenuButtonComponent(
          //   menuItems: [
          //     CustomPopupMenuItem(
          //       value: "edit",
          //       text: text.edit,
          //       icon: const Icon(Icons.edit),
          //       onTap: () => Get.to(Settings()),
          //     ),
          //   ],
          // )
        ],
      ),
      body: PostViewWidget(post: widget.post),
    );
  }
}
