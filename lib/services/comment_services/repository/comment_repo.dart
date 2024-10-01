import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';

import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';

import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';

class CommentController extends GetxController {
  final APIService _apiService = Get.find();
  final Logger _logger = Logger();

  // Variables for pagination
  var limitComments = 10;
  bool hasMoreComment = false;
  bool hasMoreChildrenComments = false;

  List<Comment> comments = [];

  Future<List<Comment>> getTopLevelComments(int postId) async {
    String path = 'basic/post-top-level-comments/$postId/$limitComments/0';

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

  Future<List<Comment>> loadMoreComment(int postId) async {
    if (hasMoreComment) {
      String path =
          'basic/post-top-level-comments/$postId/$limitComments/${(comments.length - limitComments) + limitComments}';
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
        _logger.e(response.message ?? "");
      }
    }

    // else {
    //   comments = [];
    // }

    return comments;
  }

  Future<List<Comment>> getChildrenComments(int parentId) async {
    String path = 'basic/children_comments/$parentId/$limitComments/0';

    Comment? parentComment =
        comments.firstWhereOrNull((comment) => comment.id == parentId);
    if (parentComment != null) {
      ApiResponse response = await _apiService.getRequest(path);
      if (response.statusCode == 200) {
        //Reset parentComment to avoid duplication
        parentComment.children = [];

        for (var comment in response.body["comments"]) {
          Comment childComment = Comment.fromJson(comment);

          parentComment.children.add(childComment);
        }
        hasMoreChildrenComments = response.body["hasMore"];
      } else {
        _logger.e(response.message);
      }
    } else {
      _logger.f('Parent is null on getChildrenComments');

      return [];
    }

    return comments;
  }

  Future<List<Comment>> loadChildrenComments(int parentId) async {
    if (!hasMoreChildrenComments) {
      _logger.i("No more children comments to load");
      return comments;
    }

    Comment? parentComment =
        comments.firstWhereOrNull((comment) => comment.id == parentId);
    if (parentComment == null) {
      _logger.w("Parent comment not found");
      return comments;
    }

    String path =
        'basic/children_comments/$parentId/$limitComments/${parentComment.children.length}';

    try {
      ApiResponse response = await _apiService.getRequest(path);

      if (response.statusCode == 200) {
        _logger.e(response.body["comments"]);

        List<Comment> newChildComments = (response.body["comments"] as List)
            .map((comment) => Comment.fromJson(comment))
            .toList();

        parentComment.children.addAll(newChildComments);
        hasMoreChildrenComments = response.body["hasMore"];

        _logger.i("Loaded ${newChildComments.length} more child comments");
        _logger.i("Has more children comments: $hasMoreChildrenComments");
      } else {
        _logger.e("Failed to load children comments: ${response.message}");
      }
    } catch (e) {
      _logger.e("Error loading children comments: $e");
    }

    return comments;
  }

  // unloadChildrenComments(int parentId) {
  //   Comment? parentComment =
  //       comments.firstWhere((comment) => comment.id == parentId);
  //   parentComment.children = [];
  // }

  Future<CommentDto?> addComment(CommentDto commentDto) async {
    String path = 'basic/comments';
    ApiResponse response =
        await _apiService.postRequest(path, data: commentDto.toJson());

    if (response.statusCode == 201) {
      CommentDto comment = CommentDto.fromJson(response.body["result"]);
      return comment;
    }
    _logger.e(response.statusCode);
    _logger.e(response.body ?? "");

    return null;
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

  Future<bool> likeComment(int commentId) async {
    String path = 'basic/comments/vote/$commentId';

    try {
      ApiResponse response = await _apiService.postRequest(path);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e);
    }

    return false;
  }

  Future<bool> unLikeComment(int commentId) async {
    String path = 'basic/comments/unvote/$commentId';

    try {
      ApiResponse response = await _apiService.postRequest(path);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      _logger.e(e);
    }

    return false;
  }
}
