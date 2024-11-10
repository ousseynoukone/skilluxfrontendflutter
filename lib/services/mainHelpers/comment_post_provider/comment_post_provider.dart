import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/sub_features/foreign_profile_post_holder/foreign_profile_post_holder.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/home_service_repository.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/post_service.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/foreign_user_profile_service.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

enum CommentPostProvider {
  homePostService,
  userProfilePostService,
  foreignProfilePostService,
  uniquePostPostService
}

getPostProvider(CommentPostProvider commentPostProvider, {int userId = -1}) {
  switch (commentPostProvider) {
    case CommentPostProvider.foreignProfilePostService:
      return Get.find<ForeignProfilePostHolder>();
    case CommentPostProvider.homePostService:
      return Get.find<HomePostService>();

    case CommentPostProvider.uniquePostPostService:
      return Get.find<PostService>();

    default:
      return Get.find<UserProfilePostService>();
  }
}
