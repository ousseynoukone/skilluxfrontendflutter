import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/tag/tag.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/secondary_layer.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/translator_services/translator_service.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_service.dart';

class UserProfileService extends GetxController with StateMixin<User> {
  // User API Service
  final APIService _apiService = Get.find();
  final UserService _userService = Get.find();
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  User? user;
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
      user = await _userService.getUserInfos();

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

class UserProfileFollowService extends GetxController
    with StateMixin<List<UserDTO>> {
  // User API Service
  final APIService _apiService = Get.find();
  final UserService _userService = Get.find();
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  RxBool isLoading = false.obs;

  List<UserDTO> users = [];

  void getUserFollowers({bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(users, status: RxStatus.loading());
      }
      users = await _userService.getUserFollowers();

      if (users.isEmpty) {
        change(users, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(users, status: RxStatus.error(e.toString()));
    }
  }

  void loadMoreUserFollowers(
      {bool disableLoading = false, }) async {
    try {
      if (!disableLoading) {
        change(users, status: RxStatus.loading());
      }

      isLoading.value = true;

      // Fetch followers
      List<UserDTO> newUser = await _userService.loadMoreUserFollowers();
      if (newUser.isNotEmpty) {
        // Deep copy the posts
        users = newUser.map((user) => user.clone()).toList();
      }

      if (users.isEmpty) {
        change(users, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(users, status: RxStatus.error(e.toString()));
    }
  }

  void getUserFollowging({bool disableLoading = false, }) async {
    try {
      if (!disableLoading) {
        change(users, status: RxStatus.loading());
      }
      users = await _userService.getUserFollowing();

      if (users.isEmpty) {
        change(users, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(users, status: RxStatus.error(e.toString()));
    }
  }

  void loadMoreUserFollowing(
      {bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(users, status: RxStatus.loading());
      }
      users = await _userService.loadMoreUserFollowing();

      if (users.isEmpty) {
        change(users, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(users, status: RxStatus.error(e.toString()));
    }
  }
}

class UserProfilePostService extends GetxController
    with StateMixin<List<Post>> {
  // User API Service
  final APIService _apiService = Get.find();
  final UserService _userService = Get.put(UserService());
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  List<Post>? posts;

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

      // Fetch posts
      posts = await _userService.getUserPosts();

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

  void loadMoreUserPost({bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(posts, status: RxStatus.loading());
      }
      isLoading.value = true;

      // Fetch posts
      List<Post> newPosts = await _userService.loadMoreUserPosts();
      if (newPosts.isNotEmpty) {
        // Deep copy the posts
        posts = newPosts.map((post) => post.clone()).toList();
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
    isLoading.value = false;
  }

  deletePost(int id) async {
    isLoading.value = true;

    bool response = await _userService.deletePost(id);
    Get.closeAllSnackbars();

    if (response == true) {
      Get.back();

      showCustomSnackbar(title: text!.info, message: text!.sucess);
    } else {
      showCustomSnackbar(title: text!.error, message: text!.somethingWentWrong);
    }

    isLoading.value = false;
  }
}
