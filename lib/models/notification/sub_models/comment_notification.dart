import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDTO.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';

class CommentNotification {
  final Post post;
  final Comment comment;
  final Comment? parentComment;


  CommentNotification({
    required this.post,
    required this.comment,
    this.parentComment

  });

}
