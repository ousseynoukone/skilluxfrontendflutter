import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';

class CommentNotification {
  final Post post;
  final Comment comment;


  CommentNotification({
    required this.post,
    required this.comment,

  });

}
