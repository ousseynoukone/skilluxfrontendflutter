import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/like_service.dart';

class PostService {
  final APIService _apiService = APIService();
  final LikeService _likeService = Get.find();
  final Logger _logger = Logger();

  // Use Rx<Post?> to make it observable
  var post = Rx<Post?>(null);

  Future<Post?> getOnePost({required int postId}) async {
    String path = 'basic/posts/$postId';
    ApiResponse response = await _apiService.getRequest(path);

    if (response.statusCode != 200) {
      _logger.e('Failed to fetch post: ${response.message}');
      return null;
    }

    // Assuming response.body contains the data to create a Post
    Post fetchedPost = Post.fromBody(response.body);
    post.value = fetchedPost; // Update the observable
    return fetchedPost;
  }

  Future<bool> likePost(int postId) async {
    bool response = await _likeService.likePost(postId);
    if (response) {
      post.value!.like();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unLikePost(int postId) async {
    bool response = await _likeService.unLikePost(postId);
    if (response) {
      post.value!.unlike();

      return true;
    } else {
      return false;
    }
  }

  // LOCAL UPDATE SERVE TO UPDATE POST STATE BASED ON ACTIONS THAT HAVE BEEN DONE ELSEWHERE , IT HELP TO HAVE A SEAMLESS USER'S EXPERIENCE

  localUpdateIncrementCommentNumber(postId, {int number = 1}) {
    post.value!.commentNumber += number;
    post.refresh(); // Notify listeners about the change
  }

  localUpdateDecrementCommentNumber(postId, {int number = 1}) {
    post.value!.commentNumber -= number;
    post.refresh(); // Notify listeners about the change
  }
}
