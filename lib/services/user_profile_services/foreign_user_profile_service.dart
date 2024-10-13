import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/foreign_profile_post_holder/foreign_profile_post_holder.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_service.dart';

// ForeignUserProfileService.dart
class ForeignUserProfileService {
  final APIService _apiService = Get.find();
  final UserService _userService = UserService();
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  final int userId;

  final _userInfoStreamController = StreamController<User?>.broadcast();
  Stream<User?> get userInfoStream => _userInfoStreamController.stream;

  ForeignUserProfileService({required this.userId});

  void getUserInfos({bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        _userInfoStreamController.sink.add(null);
      } 

      final user = await _userService.getUserInfos(userId: userId);
      _userInfoStreamController.sink.add(user);
    } catch (e) {
      _logger.e(e);
      _userInfoStreamController.sink.addError(e.toString());
    }
  }

  void dispose() {
    _userInfoStreamController.close();
  }
}

// ForeignUserPostsService.dart
class ForeignUserPostsService {
  final APIService _apiService = Get.find();
  final UserService _userService = UserService();
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  final int userId;
  bool hasMorePost = true;
  RxBool isLoading = false.obs;
  RxBool isEmpty = false.obs;
  final List<Post> _posts = []; // Maintain a local list of posts
  final _postsStreamController = StreamController<List<Post>?>.broadcast();
  Stream<List<Post>?> get postsStream => _postsStreamController.stream;

  final ForeignProfilePostHolder _postHolder = Get.find();

  ForeignUserPostsService({required this.userId});

  void getUserPosts({bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        _postsStreamController.sink.add(null);
      }
      isLoading.value = true;

      final posts = await _userService.getUserPosts(userId: userId);
      hasMorePost = _userService.hasMorePosts;
      if (posts.isEmpty) {
        isEmpty.value = true;
      } else {
        _posts.clear();
        _posts.addAll(posts); // Update the local list
        _postHolder.posts = posts; // Update the post Holder
      }

      _postsStreamController.sink.add(_posts);
    } catch (e) {
      _logger.e(e);
      _postsStreamController.sink.addError(e.toString());
    }
    isLoading.value = false;
  }

  void loadMoreUserPosts(
      {bool disableLoading = false,
      required int userId,
      bool isFirstLoading = false}) async {
    try {
      if (!disableLoading) {
        _postsStreamController.sink.add(null);
      }

      isLoading.value = true;

      final newPosts = await _userService.loadMoreUserPosts(
          userId: userId, isFirstLoading: isFirstLoading);

      hasMorePost = _userService.hasMorePosts;

      if (newPosts.isNotEmpty) {
        _posts.addAll(newPosts); // Update the local list
        _postHolder.posts = newPosts; // Update the post Holder

        _postsStreamController.sink.add(_posts);
      }
    } catch (e) {
      _logger.e(e);
      _postsStreamController.sink.addError(e.toString());
    }
    isLoading.value = false;
  }

  // Update the comment number locally
  void localUpdateIncrementCommentNumber(int postId, {int number = 1}) {
    final post = _posts.firstWhereOrNull((post) => post.id == postId);
    if (post != null) {
      post.commentNumber += number;
      _postsStreamController.sink.add(_posts); // Emit the updated list
    }
  }

  void localUpdateDecrementCommentNumber(int postId, {int number = 1}) {
    final post = _posts.firstWhereOrNull((post) => post.id == postId);
    if (post != null) {
      post.commentNumber -= number;
      _postsStreamController.sink.add(_posts); // Emit the updated list
    }
  }

  void dispose() {
    _postsStreamController.close();
  }
}
