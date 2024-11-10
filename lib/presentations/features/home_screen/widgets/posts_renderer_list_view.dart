import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/widgets/post_card.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:logger/logger.dart';

class PostsRendererListView extends StatefulWidget {
  final HomePostService homePostService;

  const PostsRendererListView({
    super.key,
    required this.homePostService,
  });

  @override
  _PostsRendererListViewState createState() => _PostsRendererListViewState();
}

class _PostsRendererListViewState extends State<PostsRendererListView> {
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
      if (!widget.homePostService.sneakyLoading.value) {
        widget.homePostService.loadMorePosts();
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
    widget.homePostService.refreshFeed();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: widget.homePostService.obx(
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
          onEmpty: Center(child: Text(text.noPostAvailable)),
          onError: (error) => Center(child: Text(error ?? 'Unknown error')),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(() {
      if (widget.homePostService.sneakyLoading.value) {
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
