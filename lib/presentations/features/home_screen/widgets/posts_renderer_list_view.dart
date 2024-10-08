import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/widgets/post_card.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';
import 'package:logger/logger.dart';

class PostsRendererListView extends StatefulWidget {
  final PostFeedController postFeedController;

  const PostsRendererListView({
    Key? key,
    required this.postFeedController,
  }) : super(key: key);

  @override
  _PostsRendererListViewState createState() => _PostsRendererListViewState();
}

class _PostsRendererListViewState extends State<PostsRendererListView>
     {
  final ScrollController _scrollController = ScrollController();
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }




  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!widget.postFeedController.sneakyLoading.value) {
        widget.postFeedController.loadMorePosts();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    widget.postFeedController.refreshFeed();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: widget.postFeedController.obx(
          (posts) {
            if (posts == null || posts.isEmpty) {
              return Center(child: Text(text.noPostAvailable));
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: posts.length + 1, // +1 for the loading indicator
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  return _buildLoadingIndicator();
                }
                Post post = posts[index];
                return PostCard(user: post.user!, post: post);
              },
            );
          },
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Center(child: Text('No posts available')),
          onError: (error) => Center(child: Text(error ?? 'Unknown error')),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(() {
      if (widget.postFeedController.sneakyLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
