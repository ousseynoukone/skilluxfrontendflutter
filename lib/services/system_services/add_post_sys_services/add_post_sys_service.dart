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

bool isPostNotEmpty({
  bool showError = false,
  bool checkTitle = true,
  bool checkTags = true,
  bool checkContent = true,
  bool checkHeaderImage = true,
}) {
  var text = Get.context!.localizations;

  bool result = true;

  if (checkTitle) {
    result = result && post.value.title.isNotEmpty && 
             PostTitleValidator.validate(post.value.title) == null;
  }

  if (checkTags) {
    result = result && post.value.tags.isNotEmpty;
  }

  if (checkContent) {
    result = result && post.value.content.isNotEmpty;
  }

  if (checkHeaderImage) {
    result = result && post.value.headerImageIMG != null;
  }

  if (!result && showError) {
    showCustomSnackbar(
      title: text.alert,
      message: text.nothingToShow,
      snackType: SnackType.warning,
    );
  }

  return result;
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
