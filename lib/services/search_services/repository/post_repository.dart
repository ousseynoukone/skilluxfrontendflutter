import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

class PostRepository {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  // Variables for pagination
  var cursorPost = "0";
  var limitPost = 3;
  bool hasMorePost = false;
  final RxList<Post> posts = <Post>[].obs;
  String searchString = "";

  reinititalizeParams() {
    cursorPost = "0";
    hasMorePost = false;
    posts.value = [];
  }

  Future<void> searchPosts(String searchString) async {
    this.searchString = searchString;
    if (searchString.isNotEmpty) {
      String path = "basic/search-posts/$searchString/$limitPost/0";
      List<Post> postList = [];
      posts.clear();

      ApiResponse response = await _apiService.getRequest(path);
      if (response.statusCode == 200) {
        bool hasMore = response.body["hasMore"];

        for (var post in response.body["posts"]) {
          Post fetchPost = Post.fromBody(post);
          postList.add(fetchPost);
        }

        if (postList.isNotEmpty) {
          posts.addAll(postList);
        }

        if (hasMore) {
          String nextCursor = response.body["nextCursor"];
          cursorPost = nextCursor;

          hasMorePost = hasMore;
        }
      } else {
        _logger.e(response.message);
      }
    } else {
      posts.clear();
    }
  }

  Future<void> loadMorePost() async {
    if (hasMorePost) {
      String path = "basic/search-posts/$searchString/$limitPost/$cursorPost";

      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        List<Post> postList = [];

        for (var user in response.body["post"]) {
          Post fetchPost = Post.fromBody(user);
          postList.add(fetchPost);
        }
        hasMorePost = response.body["hasMore"];

        String nextCursor = response.body["nextCursor"] ?? '0';
        cursorPost = nextCursor;

        if (postList.isNotEmpty) {
          return posts.addAll(postList);
        }
      } else {
        _logger.e(response.message);
      }
    } else {
      posts.value = [];
    }
  }
}
