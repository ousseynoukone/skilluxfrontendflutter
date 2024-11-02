import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/widgets/post_card.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/post_container.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/helpers/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/search_services/search_service.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({super.key});

  @override
  State<SearchPost> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchPost> {
  final SearchService _searchService = Get.find();

  @override
  void initState() {
    _searchService.searchPost(searchTerm.value);

    searchTerm.listen((search) {
      _searchService.searchPost(search);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
                itemCount: _searchService.posts.length,
                itemBuilder: (context, int index) {
                  Post post = _searchService.posts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: PostContainer(
                        post: post,
                        commentPostProvider:
                            CommentPostProvider.homePostService),
                  );
                }),
          ),
        ));
  }
}
