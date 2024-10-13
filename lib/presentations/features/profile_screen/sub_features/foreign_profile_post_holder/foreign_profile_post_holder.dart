// THIS IS CLASS ACT LIKE A BOND BEETWEN FETCHED POST ON ForeignUserPostsService AND CommentScreenForeignUser
// THIS HELP TO MAKE POST AVAILABLE FOR CommentScreenForeignUser

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';

class ForeignProfilePostHolder extends GetxController {
  final RxList<Post> _posts = <Post>[].obs;
  final Logger _logger = Logger();

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
}
