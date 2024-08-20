import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_service.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';

class ForeignUserProfileService extends GetxController with StateMixin<User> {
  final APIService _apiService = Get.find();
  final UserService _userService = Get.find();
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  final int userId;

  User? user;

  ForeignUserProfileService({required this.userId});

  @override
  void onInit() {
    super.onInit();
    getUserInfos();
  }

  void getUserInfos({bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(user, status: RxStatus.loading());
      }

      user = await _userService.getUserInfos(userId: userId);

      if (user != null) {
        if (user!.isEmpty()) {
          change(user, status: RxStatus.empty());
        } else {
          change(user, status: RxStatus.success());
        }
      } else {
        change(user, status: RxStatus.error(text!.errorUnexpected));
        showCustomSnackbar(title: text!.error, message: text!.errorUnexpected);
      }
    } catch (e) {
      _logger.e(e);
      change(user, status: RxStatus.error(e.toString()));
    }
  }
}

class ForeignUserPostsService extends GetxController
    with StateMixin<List<Post>> {
  final APIService _apiService = Get.find();
  final UserService _userService = Get.find();
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  final int userId;

  List<Post>? posts;

  ForeignUserPostsService({required this.userId});

  @override
  void onInit() {
    super.onInit();
    getUserPosts();
  }

  void getUserPosts({bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(posts, status: RxStatus.loading());
      }

      posts = await _userService.getUserPosts(userId: userId);

      if (posts != null) {
        if (posts!.isEmpty) {
          change(posts, status: RxStatus.empty());
        } else {
          change(posts, status: RxStatus.success());
        }
      } else {
        change(posts, status: RxStatus.error(text!.errorUnexpected));
        showCustomSnackbar(title: text!.error, message: text!.errorUnexpected);
      }
    } catch (e) {
      _logger.e(e);
      change(posts, status: RxStatus.error(e.toString()));
    }
  }

  void loadMoreUserPosts(
      {bool disableLoading = false, required int userId}) async {
    try {
      if (!disableLoading) {
        change(posts, status: RxStatus.loading());
      }

      List<Post> newPosts =
          await _userService.loadMoreUserPosts(userId: userId);
      if (newPosts.isNotEmpty) {
        posts = [...?posts, ...newPosts];
      }

      if (posts != null) {
        if (posts!.isEmpty) {
          change(posts, status: RxStatus.empty());
        } else {
          change(posts, status: RxStatus.success());
        }
      } else {
        change(posts, status: RxStatus.error(text!.errorUnexpected));
        showCustomSnackbar(title: text!.error, message: text!.errorUnexpected);
      }
    } catch (e) {
      _logger.e(e);
      change(posts, status: RxStatus.error(e.toString()));
    }
  }
}
