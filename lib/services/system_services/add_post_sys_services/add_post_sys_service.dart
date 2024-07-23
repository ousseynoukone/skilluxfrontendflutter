import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/post/sub_models/section.dart';

class AddPostSysService extends GetxController {
  // Observable Post object
  Rx<Post?> post = Rx<Post?>(null);

  final isLoading = false.obs;

  void addPost(Post newpost) {
    post.value = newpost;
  }

  void clearPost() {
    post.value = null;
  }
}
