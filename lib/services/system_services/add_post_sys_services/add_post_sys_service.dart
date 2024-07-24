import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/validators/post_title_validator.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/get_x_snackbar.dart';
import 'package:logger/logger.dart';

class AddPostSysService extends GetxController {
  // Initialize with an empty Post object
  Rx<Post> post = Rx<Post>(Post(tags: [], title: '', content: ''));
  final Logger _logger = Logger();

  final isLoading = false.obs;

  void addPost(Post newPost) {
    post.value = newPost;
  }

  clearContent() {
    post.value = Post(
      tags: post.value.tags,
      title: post.value.title,
      content: '',
    );
  }

  bool isPostNotEmpty({bool showError = false}) {
    var text = Get.context!.localizations;

    bool result = post.value.title.isNotEmpty &&
        PostTitleValidator.validate(post.value.title) == null &&
        post.value.tags.isNotEmpty &&
        post.value.content.isNotEmpty &&
        post.value.headerImageIMG != null;

    if (!result && showError) {
      showCustomSnackbar(
        title: text.alert,
        message: text.nothingToShow,
        snackType: SnackType.warning,
      );
    }

    return result;
  }

  void dumpPostValue() {
    _logger.d('Post Dump:');
    _logger.d('Title: ${post.value.title}');
    _logger.d('Content: ${post.value.content}');
    _logger.d('Tags: ${post.value.tags}');
    _logger.d(
        'Header Image: ${post.value.headerImageIMG != null ? "Present" : "Not present"}');

    // Add any other fields you want to log
  }

  isContentEmpty() {
    return post.value.content.isNotEmpty;
  }

  void clearPost() {
    // Reset to a new empty Post object instead of null
    post.value = Post(
      title: '',
      content: '',
      tags: [],
    );
  }
}
