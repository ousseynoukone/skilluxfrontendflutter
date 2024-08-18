import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_tags.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_ago_format.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/glass_neuphormism.dart';

class PostContainer extends StatefulWidget {
  final Post post;

  const PostContainer({super.key, required this.post});

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  @override
  Widget build(BuildContext context) {
    // Access the post object from the widget
    final post = widget.post;

    // Retrieve localizations and text theme
    final text = context.localizations;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

// Method to build the post image or icon
    Widget buildPostImage() {
      const double size = 50.0; // Define the size of the image and icon

      if (post.headerImageUrl != null && post.headerImageUrl!.isNotEmpty) {
        return SizedBox(
          width: size,
          height: size,
          child: Image.network(
            post.headerImageUrl!,
            fit: BoxFit.cover, // Ensures the image covers the whole space
          ),
        );
      } else {
        return SizedBox(
          width: size,
          height: size,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background color of the icon container
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: const Icon(
              Icons.image_not_supported,
              size: 30, // Icon size
              color: Colors.black, // Icon color
            ),
          ),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: GlassMorphism(
        blur: 20,
        opacity: 0.3,
        color: colorScheme.primary,
        child: ListTile(
          leading: buildPostImage(),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: textTheme.titleSmall
                    ?.copyWith(fontSize: 14), // Example text style
              ),
              Container(
                  height: 20,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: displayTags(post.tags)),
            ],
          ),
          subtitle: displayDateTime(post.createdAt, fontSize: 12),
          trailing: post.isPublished!
              ? getCustomChip(text.postPosted, Icons.check_rounded,
                  fontSize: 12)
              : getCustomChip(text.postNotPosted, Icons.close, fontSize: 12),
        ),
      ),
    );
  }
}
