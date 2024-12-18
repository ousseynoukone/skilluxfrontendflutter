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
  var limitPosts = 10;
  bool hasMorePosts = false;

  var cursorFollowers = "0";
  var limitFollowers = 30;
  bool hasMoreFollowers = false;

  var cursorFollowing = "0";
  var limitFollowing = 30;
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
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        hasMorePosts = response.body["hasMore"];
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

  Future<bool> followUser(int userId) async {
    String path = "basic/users/follow/$userId";
    try {
      ApiResponse response = await _apiService.postRequest(path);
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return false;
  }

  Future<bool> unfollowUser(int userId) async {
    String path = "basic/users/unfollow/$userId";
    try {
      ApiResponse response = await _apiService.postRequest(path);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e.toString());
    }
    return false;
  }

  Future<bool?> isFollower(int userId) async {
    String path = "basic/users/is-follower/$userId";
    try {
      ApiResponse response = await _apiService.getRequest(path);
      if (response.statusCode == 200) {
        return response.body["isFollowing"];
      } else {
        return null;
      }
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }

  Future<List<int>> getUserLikesId({bool isForPost = false}) async {
    var ressourceType = isForPost ? "post" : "comment";
    List<int> likedElementId = [];

    String path = "basic/user-likes-ids/$ressourceType";
    try {
      ApiResponse response = await _apiService.getRequest(path);
      if (response.statusCode == 200) {
        for (var id in response.body) {
          likedElementId.add(id);
        }
      }

      return likedElementId;
    } catch (e) {
      _logger.e(e.toString());
      rethrow;
    }
  }
}
