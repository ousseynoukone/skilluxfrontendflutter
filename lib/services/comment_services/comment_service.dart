import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/foreign_profile_post_holder/foreign_profile_post_holder.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/comment_repo.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/helper.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class CommentService extends GetxController with StateMixin<RxList<Comment>> {
  final APIService _apiService = Get.find();
  final CommentRepo _commentRepo = Get.put(CommentRepo());
  final CommentPostProvider commentPostProvider;
  final UserProfileService _userProfileService = Get.find();

  CommentService({required this.commentPostProvider});

  RxBool isTopCommentLoading = false.obs;
  RxBool isCommentLoading = false.obs;
  RxBool isAddingCommentLoading = false.obs;
  RxBool isCommentChildCommentLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  RxList<Comment> comments = <Comment>[].obs;
  dynamic postService;

  @override
  void onInit() {
    postService = getPostProvider(commentPostProvider);
    // IF POSTSERVICE IS NULL IT CAN RELY ON ForeignProfilePostHolder TO UPDAT POSTS IF NEEDED FOR FOREIGN PROFILE COMMENT
    postService ??= Get.find<ForeignProfilePostHolder>();

    super.onInit();
  }

  switchPostProviderToForeignProfilePostHolder({bool switchBack = false}) {
    if (switchBack == false) {
      postService = Get.find<ForeignProfilePostHolder>();
    } else {
      postService = Get.find<PostFeedController>();
    }
  }

  void getPostTopComments(int postId, {bool disableLoading = false}) async {
    try {
      comments.value = [];
      if (!disableLoading) {
        change(comments, status: RxStatus.loading());
      }
      var fetchedComments = await _commentRepo.getTopLevelComments(postId);
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
      List<Comment>? newComment = await _commentRepo.loadMoreComment(postId);

      if (newComment != null) {
        if (newComment.isNotEmpty) {
          // Deep copy the posts
          comments.value =
              newComment.map((comment) => comment.clone()).toList();

          change(comments, status: RxStatus.success());
        }
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

      var fetchedComments = await _commentRepo.getChildrenComments(parentId);

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
      List<Comment>? newComment =
          await _commentRepo.loadChildrenComments(parentId);
      if (newComment != null && newComment.isNotEmpty) {
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
  //   _commentRepo.unloadChildrenComments(parentId);
  // }
  Future<void> deleteComment(Comment comment) async {
    try {
      // Delete the comment from the backend
      await _commentRepo.deleteComment(comment.id!);

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
    _logger.w(postService);
    isAddingCommentLoading.value = true;
    CommentDto? response = await _commentRepo.addComment(commentDto);
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
        insertChildToParent(comment, comments);
      }

      change(comments, status: RxStatus.success());

      Get.back();

      // TO UPDATE RELATED POST COMMENT NUMBER
      postService.localUpdateIncrementCommentNumber(commentDto.postId);
    } else {
      showCustomSnackbar(
          title: text!.error,
          message: text!.errorUnexpected,
          snackType: SnackType.error);
    }
    isAddingCommentLoading.value = false;
  }

  Future<bool> likeComment(int commentId) async {
    bool response = await _commentRepo.likeComment(commentId);
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
    bool response = await _commentRepo.unLikeComment(commentId);
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
