import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';

class HomeServiceRepository {
  FeedType feedType;
  HomeServiceRepository({required this.feedType});

  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  // Variables for pagination
  var cursorPosts = "0";
  var limitPosts = 3;
  bool hasMorePosts = false;
  List<Post> poststFeed = [];

  switchFeedMod(FeedType feedType) {
    this.feedType = feedType;
  }

  reinititalizeParams() {
    cursorPosts = "0";
    hasMorePosts = false;
    poststFeed = [];
  }

  Future<List<Post>> getPosts({int userId = 0}) async {
    String path = "basic/${feedType.value}/$limitPosts/0";
    List<Post> posts = [];
    poststFeed = [];
    cursorPosts = '0';

    ApiResponse response = await _apiService.getRequest(path);
    if (response.statusCode == 200) {
      bool hasMore = response.body["hasMore"];

      for (var post in response.body["posts"]) {
        Post fetchPost = Post.fromBody(post);
        posts.add(fetchPost);
      }

      if (posts.isNotEmpty) {
        poststFeed.addAll(posts);
      }

      if (hasMore) {
        String nextCursor = response.body["nextCursor"];
        cursorPosts = nextCursor;

        hasMorePosts = hasMore;
      }
    } else {
      _logger.e(response.message);
    }

    return posts;
  }

  Future<List<Post>> loadMorePosts() async {
    if (hasMorePosts) {
      String path = "basic/${feedType.value}/$limitPosts/$cursorPosts";
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        hasMorePosts = response.body["hasMore"];
        List<Post> posts = [];

        for (var post in response.body["posts"]) {
          posts.add(Post.fromBody(post));
        }

        String nextCursor = response.body["nextCursor"] ?? '0';
        cursorPosts = nextCursor;
        _logger.f(cursorPosts);

        if (posts.isNotEmpty) {
          return posts;
        }
      } else {
        _logger.e(response.message);
      }
    } else {
      poststFeed = [];
    }

    return poststFeed;
  }

  Future<bool> likePost(int postId) async {
    String path = 'basic/posts/vote/$postId';

    try {
      ApiResponse response = await _apiService.postRequest(path);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e);
    }

    return false;
  }

  Future<bool> unLikePost(int postId) async {
    String path = 'basic/posts/unvote/$postId';

    try {
      ApiResponse response = await _apiService.postRequest(path);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e);
    }

    return false;
  }
}
