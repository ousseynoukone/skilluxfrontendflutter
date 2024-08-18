import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/core/api_service/response_data_structure.dart';
import 'package:skilluxfrontendflutter/core/state_managment/app_state_managment.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/tag/tag.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/secondary_layer.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/translator_services/translator_service.dart';
import 'package:skilluxfrontendflutter/services/user_services/controller/user_service.dart';

class UserProfileService extends GetxController with StateMixin<User> {
  // User API Service
  final APIService _apiService = Get.find();
  final UserService _userService = Get.put(UserService());
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

class UserProfilePostService extends GetxController
    with StateMixin<List<Post>> {
  // User API Service
  final APIService _apiService = Get.find();
  final UserService _userService = Get.put(UserService());
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  List<Post>? posts;
  var cursor = 0;
  var limit = 0;
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
      posts = await _userService.getUserPosts(limit, cursor);

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
