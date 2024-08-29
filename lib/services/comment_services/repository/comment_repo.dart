import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/auh_services/controller/auth_controller.dart';
import 'package:logger/logger.dart';

import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:logger/logger.dart';

class CommentController extends GetxController {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  // Variables for pagination
  var limitComments = 2;
  bool hasMoreComment = false;

  List<Comment> comments = [];

  Future<List<Comment>> getTopLevelComments(int postId) async {
    String path =
        'basic/post-top-level-comments/$postId/$limitComments/${comments.length + limitComments}';

    ApiResponse response = await _apiService.getRequest(path);
    if (response.statusCode == 200) {
      for (var comment in response.body["comments"]) {
        Comment newComment = Comment.fromJson(comment);
        comments.add(newComment);
      }
      hasMoreComment = response.body["hasMore"];
    } else {
      _logger.e(response.message);
    }

    return comments;
  }

  Future<List<Comment>> loadMoreComment(int postId,
      {bool isFirstLoading = false}) async {
    if (hasMoreComment || isFirstLoading) {
      String path =
          'basic/post-top-level-comments/$postId/$limitComments/${comments.length + limitComments}';
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        hasMoreComment = response.body["hasMore"];
        List<Comment> newComments = [];

        for (var comment in response.body["comments"]) {
          newComments.add(Comment.fromJson(comment));
        }
        if (newComments.isNotEmpty) {
          comments.addAll(newComments);
        }
      } else {
        _logger.e(response.message);
      }
    } else {
      comments = [];
    }

    return comments;
  }

  Future<bool> deleteComment(int commentId) async {
    String path = 'basic/comments/$commentId';

    ApiResponse response = await _apiService.deleteRequest(path);

    if (response.statusCode == 200) {
      return true;
    }
    _logger.e(response.statusCode);
    return false;
  }
}
