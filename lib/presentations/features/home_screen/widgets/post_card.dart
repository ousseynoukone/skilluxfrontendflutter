import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/helpers/display_time_ago.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/reading_time_calculator/reading_time_calculator.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/foreign_profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/like.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/icon_button.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';

class PostCard extends StatefulWidget {
  final UserDTO user;
  final Post post;

  const PostCard({super.key, required this.user, required this.post});

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

    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            postAndUserPreview(themeText),
            const Divider(
              thickness: 0.2,
            )
          ],
        ));
  }

  Widget postAndUserPreview(themeText) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(
                () => ForeignProfileScreen(foreignUserId: widget.post.userId!));
          },
          child: displayUserPreview(widget.user,
              trailing: displayTimeAgoSync(widget.post.createdAt),
              zeroPadding: true),
        ),
        _postPreView(themeText), // Display post preview
      ],
    );
  }

  Widget _actionsButton(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LikeWidget(
          isForPost: true,
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
    );
  }

  Widget _postPreviewComponent(TextTheme textTheme) {
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
      ],
    );
  }

  _postPreView(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: _postPreviewComponent(textTheme),
          onTap: () {
            Get.to(() => PostView(
                  post: widget.post,
                  commentPostProvider: CommentPostProvider.homePostService,
                ));
          },
        ),
        _actionsButton(textTheme)
      ],
    );
  }
}
