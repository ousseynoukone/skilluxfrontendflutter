import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';

class UserService extends GetxController {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  Future<User?> getUserInfos() async {
    String path = 'basic/users';
    User? user;

    ApiResponse response = await _apiService.getRequest(path);
    if (response.statusCode == 200) {
      user = User.fromBody(response.body);
    } else {
      _logger.e(response.message);
    }

    return user;
  }

  Future<List<Post>> getUserPosts(limit, cursor) async {
    String path = "basic/users/post/$limit/$cursor";
    List<Post> posts = [];

    ApiResponse response = await _apiService.getRequest(path);

    if (response.statusCode == 200) {
      for (var post in response.body["posts"]) {
        posts.add(Post.fromBody(post));
      }
    } else {
      _logger.e(response.message);
    }

    return posts;
  }
}
