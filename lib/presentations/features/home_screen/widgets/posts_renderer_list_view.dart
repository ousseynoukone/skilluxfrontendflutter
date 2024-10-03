// posts_renderer_list_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/widgets/post_card.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';

class PostsRendererListView extends StatelessWidget {
  final PostFeedController postFeedController;

  const PostsRendererListView({
    super.key,
    required this.postFeedController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (postFeedController.isLoading.value && postFeedController.recommendedPosts.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: postFeedController.recommendedPosts.length,
        itemBuilder: (context, index) {
          Post post = postFeedController.recommendedPosts[index];
          return PostCard(user: post.user!, post: post);
        },
      );
    });
  }
}