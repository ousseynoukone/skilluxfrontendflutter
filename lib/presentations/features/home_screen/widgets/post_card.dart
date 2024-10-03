import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/icon_button.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';

class PostCard extends StatefulWidget {
  final UserDTO user;
  final Post post;

  const PostCard({Key? key, required this.user, required this.post})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late PostFeedController _postFeedController;

  @override
  void initState() {
    super.initState();
    // Initialize any required controllers or state here
    _postFeedController = Get.find(); // Assuming this is necessary
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            postAndUserPreview(themeText),
            const Divider(
              thickness: 0.1,
            )
          ],
        ));
  }

  Widget postAndUserPreview(themeText) {
    return Column(
      children: [
        displayUserPreview(widget.user,
            trailing: displayTimeAgoSync(widget.post.createdAt)),
        _postPreView(themeText), // Display post preview
      ],
    );
  }

  Widget _postPreView(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        displayPostCoverPhoto(widget.post.headerImageUrl),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(widget.post.title,
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500)),
        SizedBox(
          height: Get.height * 0.01,
        ),
        getCustomChip(
            getReadingTime(widget.post.content.content!), Icons.timer_outlined,
            isBackgroundTransparent: true),
        Row(
          children: [
            LikeWidget(
              initialLikes: widget.post.votesNumber ?? 0,
              elementId: widget.post.id!,
              likeFunction: _postFeedController.likePost,
              unlikeFunction: _postFeedController.unLikePost,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {},
                ),
                SizedBox(width: Get.width * 0.01),
                Text(widget.post.commentNumber.toString(),
                    style: textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
