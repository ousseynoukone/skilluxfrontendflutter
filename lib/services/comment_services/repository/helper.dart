import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

//Dunction to remove a comment from a list or its immediate children
bool removeCommentFromList(List<Comment> commentList, Comment commentToRemove) {
  final UserProfilePostService _postService = Get.find();

  for (int i = 0; i < commentList.length; i++) {
    if (commentList[i].id == commentToRemove.id) {
      commentList.removeAt(i);
      // Update related post comment number
      _postService.localUpdateDecrementCommentNumber(commentToRemove.postId,
          number: commentToRemove.descendantCount + 1);
      return true;
    }

    // Check immediate children
    int childIndex = commentList[i]
        .children
        .indexWhere((child) => child.id == commentToRemove.id);
    if (childIndex != -1) {
      commentList[i].children.removeAt(childIndex);
      commentList[i].decrementDescendantCount();
      return true;
    }
  }
  return false;
}

// Insert child comment to it parent
insertChildToParent(Comment childComment, List<Comment> comments) {
  Comment? parentComment = comments
      .firstWhereOrNull((comment) => comment.id == childComment.parentId);

  if (parentComment != null) {
    parentComment.children.add(childComment);
    parentComment.incrementDescendantCount();
  }
}
