// THIS IS CLASS ACT LIKE A BOND BEETWEN FETCHED POST ON ForeignUserPostsService AND CommentScreenForeignUser
// THIS HELP TO MAKE POST AVAILABLE FOR CommentScreenForeignUser

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/like_service.dart';

class ForeignProfilePostHolder extends GetxController {
  final RxList<Post> _posts = <Post>[].obs;
  final Logger _logger = Logger();
  final LikeService _likeService = LikeService();

  List<Post> get posts => _posts;

  set posts(List<Post> value) {
    _posts.clear();
    _posts.assignAll(value);
  }

  localUpdateIncrementCommentNumber(postId, {int number = 1}) {
    var post = _posts.firstWhereOrNull(
      (post) => post.id == postId,
    );
    post!.commentNumber += number;
    _posts.refresh(); // Notify subscribers
  }

  localUpdateDecrementCommentNumber(postId, {int number = 1}) {
    var post = _posts.firstWhereOrNull(
      (post) => post.id == postId,
    );
    post!.commentNumber -= number;
    _posts.refresh(); // Notify subscribers
  }

  Future<bool> likePost(int postId) async {
    bool response = await _likeService.likePost(postId);
    if (response) {
      var index = _posts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        _posts[index].like();
        _posts.refresh();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unLikePost(int postId) async {
    bool response = await _likeService.unLikePost(postId);
    if (response) {
      var index = _posts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        _posts[index].unlike();
        _posts.refresh();
      }
      return true;
    } else {
      return false;
    }
  }
}
