import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:skilluxfrontendflutter/services/comment_services/repository/comment_repo.dart';

class CommentService extends GetxController with StateMixin<List<Comment>> {
  final APIService _apiService = Get.find();
  final CommentController _commentController = Get.find();
  RxBool isLoading = false.obs;
  final Logger _logger = Logger();
  final text = Get.context?.localizations;
  List<Comment> comments = <Comment>[].obs;

  void getPostTopComments(int postId, {bool disableLoading = false}) async {
    try {
      if (!disableLoading) {
        change(comments, status: RxStatus.loading());
      }
      comments = await _commentController.getTopLevelComments(postId);

      if (comments.isEmpty) {
        change(comments, status: RxStatus.empty());
      } else {

        change(comments, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e(e);
      change(comments, status: RxStatus.error(e.toString()));
    }
  }
}
