import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';

class UserService extends GetxController {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  // Variables for pagination
  var cursorPosts = "0";
  var limitPosts = 4;
  bool hasMorePosts = false;

  var cursorFollowers = "0";
  var limitFollowers = 20;
  bool hasMoreFollowers = false;

  var cursorFollowing = "0";
  var limitFollowing = 20;
  bool hasMoreFollowing = false;

  List<Post> userPosts = [];
  List<UserDTO> userFollowers = [];
  List<UserDTO> userFollowing = [];

  Future<User?> getUserInfos({int userId = 0}) async {
    String path = 'basic/users/$userId';
    User? user;

    ApiResponse response = await _apiService.getRequest(path);
    if (response.statusCode == 200) {
      user = User.fromBody(response.body);
    } else {
      _logger.e(response.message);
    }

    return user;
  }

  Future<List<Post>> getUserPosts({int userId = 0}) async {
    String path = "basic/users/post/$limitPosts/0/$userId";
    _logger.d("REQUEST MADE : getUserPosts");
    List<Post> posts = [];
    userPosts = [];
    cursorPosts = '0';

    ApiResponse response = await _apiService.getRequest(path);

    if (response.statusCode == 200) {
      bool hasMore = response.body["hasMore"];

      for (var post in response.body["posts"]) {
        posts.add(Post.fromBody(post));
      }

      if (posts.isNotEmpty) {
        userPosts.addAll(posts);
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

  Future<List<Post>> loadMoreUserPosts(
      {int userId = 0, bool isFirstLoading = false}) async {
    if (hasMorePosts || isFirstLoading) {
      String path = "basic/users/post/$limitPosts/$cursorPosts/$userId";
      _logger.f(path);
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        hasMorePosts = response.body["hasMore"];
        _logger.d(hasMorePosts);
        List<Post> posts = [];

        for (var post in response.body["posts"]) {
          posts.add(Post.fromBody(post));
        }
        if (posts.isNotEmpty) {
          userPosts.addAll(posts);
        }

        String nextCursor = response.body["nextCursor"] ?? '0';
        cursorPosts = nextCursor;
      } else {
        _logger.e(response.message);
      }
    } else {
      userPosts = [];
    }

    return userPosts;
  }

  Future<bool> deletePost(int id) async {
    String path = "basic/posts/$id";
    try {
      ApiResponse response = await _apiService.deleteRequest(path);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _logger.e(e.toString());
      return false;
    }
  }

  Future<List<UserDTO>> getUserFollowers({int userId = 0}) async {
    String path = "basic/users/followers/$limitFollowers/0/$userId";
    List<UserDTO> users = [];
    userFollowers = [];
    cursorFollowers = '0';

    ApiResponse response = await _apiService.getRequest(path);

    if (response.statusCode == 200) {
      bool hasMore = response.body["hasMore"];

      for (var user in response.body["followers"]) {
        users.add(UserDTO.fromBody(user));
      }

      if (users.isNotEmpty) {
        userFollowers.addAll(users);
      }

      if (hasMore) {
        String nextCursor = response.body["nextCursor"];
        cursorFollowers = nextCursor;
        hasMoreFollowers = hasMore;
      }
    } else {
      _logger.e(response.message);
    }

    return users;
  }

  Future<List<UserDTO>> loadMoreUserFollowers({int userId = 0}) async {
    if (hasMoreFollowers) {
      String path =
          "basic/users/followers/$limitFollowers/$cursorFollowers/$userId";

      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        hasMoreFollowers = response.body["hasMore"];

        List<UserDTO> users = [];

        for (var user in response.body["followers"]) {
          users.add(UserDTO.fromBody(user));
        }
        if (users.isNotEmpty) {
          userFollowers.addAll(users);
        }

        String nextCursor = response.body["nextCursor"] ?? '0';
        cursorFollowers = nextCursor;
      } else {
        _logger.e(response.message);
      }
    } else {
      userFollowers = [];
    }

    return userFollowers;
  }

  Future<List<UserDTO>> getUserFollowing({int userId = 0}) async {
    String path = "basic/users/following/$limitFollowing/0/$userId";
    List<UserDTO> users = [];
    userFollowing = [];
    cursorFollowing = '0';

    ApiResponse response = await _apiService.getRequest(path);

    if (response.statusCode == 200) {
      bool hasMore = response.body["hasMore"];

      for (var user in response.body["following"]) {
        users.add(UserDTO.fromBody(user));
      }

      if (users.isNotEmpty) {
        userFollowing.addAll(users);
      }

      if (hasMore) {
        String nextCursor = response.body["nextCursor"];
        cursorFollowing = nextCursor;
        hasMoreFollowing = hasMore;
      }
    } else {
      _logger.e(response.message);
    }

    return users;
  }

  Future<List<UserDTO>> loadMoreUserFollowing({int userId = 0}) async {
    if (hasMoreFollowing) {
      String path =
          "basic/users/following/$limitFollowing/$cursorFollowing/$userId";

      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        hasMoreFollowing = response.body["hasMore"];

        List<UserDTO> users = [];

        for (var user in response.body["following"]) {
          users.add(UserDTO.fromBody(user));
        }
        if (users.isNotEmpty) {
          userFollowing.addAll(users);
        }

        String nextCursor = response.body["nextCursor"] ?? '0';
        cursorFollowing = nextCursor;
      } else {
        _logger.e(response.message);
      }
    } else {
      userFollowing = [];
    }

    return userFollowing;
  }
}
