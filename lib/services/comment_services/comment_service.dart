import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/comment_repo.dart';

class CommentService extends GetxController with StateMixin<RxList<Comment>> {
  final APIService _apiService = Get.find();
  final CommentController _commentController = Get.find();
  RxBool isLoading = false.obs;
  RxBool isCommentLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  RxList<Comment> comments = <Comment>[].obs;

  void getPostTopComments(int postId, {bool disableLoading = false}) async {
    try {
      comments.value = [];
      if (!disableLoading) {
        change(comments, status: RxStatus.loading());
      }
      var fetchedComments =
          await _commentController.getTopLevelComments(postId);
      comments.assignAll(fetchedComments);
      if (comments.isEmpty) {
        change(comments, status: RxStatus.empty());
      } else {
        change(comments, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(comments, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> loadMoreTopComments(int postId,
      {bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(comments, status: RxStatus.loading());
      }
      isLoading.value = true;
      List<Comment> newComment =
          await _commentController.loadMoreComment(postId);

      if (newComment.isNotEmpty) {
        // Deep copy the posts
        comments.value = newComment.map((comment) => comment.clone()).toList();
        change(comments, status: RxStatus.success());
      }

      if (comments.isEmpty) {
        // Handle empty state if needed
      }
    } catch (e) {
      _logger.e(e);
      // Handle error state if needed
      change(comments, status: RxStatus.error(e.toString()));
    }
    isLoading.value = false;
  }

  deleteComment(int commentId) async {
    isCommentLoading.value = true;
    bool response = await _commentController.deleteComment(commentId);
    if (response) {
      // Remove the deleted comment from the comments array
      comments.removeWhere((comment) => comment.id == commentId);

      // Update the state
      change(comments, status: RxStatus.success());

      showCustomSnackbar(
          title: text!.info,
          message: text!.sucess,
          snackType: SnackType.success);
    } else {
      showCustomSnackbar(title: text!.error, message: text!.errorUnexpected);
    }
    isCommentLoading.value = false;
  }

  Future<bool> likeComment(int commentId) async {
    bool response = await _commentController.likeComment(commentId);
    if (response) {
      var index = comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        comments[index].likeComment();
        comments.refresh();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unLikeComment(int commentId) async {
    bool response = await _commentController.unLikeComment(commentId);
    if (response) {
      var index = comments.indexWhere((comment) => comment.id == commentId);
      if (index != -1) {
        comments[index].unLikeComment();
        comments.refresh();
      }

      return true;
    } else {
      return false;
    }
  }
}
