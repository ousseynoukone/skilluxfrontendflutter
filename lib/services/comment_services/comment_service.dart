import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/comment_repo.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/helper.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class CommentService extends GetxController with StateMixin<RxList<Comment>> {
  final APIService _apiService = Get.find();
  final CommentController _commentController = Get.find();
  final UserProfilePostService _postService = Get.find();
  final UserProfileService _userProfileService = Get.find();

  RxBool isTopCommentLoading = false.obs;
  RxBool isCommentLoading = false.obs;
  RxBool isAddingCommentLoading = false.obs;
  RxBool isCommentChildCommentLoading = false.obs;
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
        isTopCommentLoading.value = true;
      }
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
    isTopCommentLoading.value = false;
  }

  Future<void> getChildrenComments(int parentId,
      {bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        isCommentChildCommentLoading.value = true;
      }

      var fetchedComments =
          await _commentController.getChildrenComments(parentId);

      if (fetchedComments.isNotEmpty) {
        comments.assignAll(fetchedComments);
        change(comments, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(comments, status: RxStatus.error(e.toString()));
    }
    isCommentChildCommentLoading.value = false;
  }

  Future<void> loadChildrenComments(int parentId,
      {bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        // change(comments, status: RxStatus.loading());
        isCommentChildCommentLoading.value = true;
      }
      List<Comment> newComment =
          await _commentController.loadChildrenComments(parentId);
      if (newComment.isNotEmpty) {
        // Deep copy the posts
        comments.value = newComment.map((comment) => comment.clone()).toList();
        change(comments, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(comments, status: RxStatus.error(e.toString()));
    }
    isCommentChildCommentLoading.value = false;
  }

  // void unloadChildrenComments(int parentId) {
  //   _commentController.unloadChildrenComments(parentId);
  // }
  Future<void> deleteComment(Comment comment) async {
    try {
      // Delete the comment from the backend
      await _commentController.deleteComment(comment.id!);

      // Remove the deleted comment from the comments array or its children
      bool removed = removeCommentFromList(comments, comment);

      if (removed) {
        // Update the state only if a comment was actually removed
        change(comments, status: RxStatus.success());
      }
    } catch (e) {
      // Show error snackbar
      showCustomSnackbar(
        title: text!.error,
        message: text!.errorUnexpected,
      );
    }
  }

  addComment(CommentDto commentDto) async {
    isAddingCommentLoading.value = true;
    CommentDto? response = await _commentController.addComment(commentDto);
    if (response != null) {
      // Update the state
      User user = _userProfileService.user!;
      UserDTO userDto = UserDTO(
          id: user.id,
          fullName: user.fullName,
          username: user.username,
          profilePicture: user.profilePicture);

      Comment comment;

      if (commentDto.parentId == null) {
        comment = Comment.createNewComment(response, userDto);
        comments.insert(0, comment);
      } else {
        User? fUser;

        if (response.targetId != null) {
          fUser = await _userProfileService.getOneUserInfo(response.targetId!);
        }

        UserDTO? target;
        if (fUser != null) {
          target = UserDTO(
              id: fUser.id, fullName: fUser.fullName, username: fUser.username);
        }
        comment = Comment.createNewComment(response, userDto, target: target);
        // Insert this child comment to it's parent children
        comment.log();
        insertChildToParent(comment, comments);
      }

      change(comments, status: RxStatus.success());

      Get.back();

      // TO UPDATE RELATED POST COMMENT NUMBER
      _postService.localUpdateIncremenCommentNumber(commentDto.postId);
    } else {
      showCustomSnackbar(
          title: text!.error,
          message: text!.errorUnexpected,
          snackType: SnackType.error);
    }
    isAddingCommentLoading.value = false;
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
