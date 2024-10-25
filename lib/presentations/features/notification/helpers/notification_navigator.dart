import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/post_service.dart';
import 'package:logger/logger.dart';

class NotificationNavigator {
  final Logger _logger = Logger();
  navigateToRessource(NotificationModel notification) async {
    switch (notification.type) {
      case NotificationType.post || NotificationType.vote:
        PostService _postService = Get.put(PostService());
        Post? post =
            await _postService.getOnePost(postId: notification.ressource!.id);
        Get.to(() => PostView(
          
              post: post!,
              commentPostProvider: CommentPostProvider.uniquePostPostService,
            ));

        break;
      default:
    }
  }
}
