import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/services/search_services/repository/post_repository.dart';
import 'package:skilluxfrontendflutter/services/search_services/repository/user_repository.dart';
import 'package:logger/logger.dart';

class SearchService extends GetxController {
  // Repositories
  final UserRepository _userRepository = Get.put(UserRepository());
  final PostRepository _postRepository = Get.put(PostRepository());

  // Observable variables
  final RxList<User> users = <User>[].obs;
  final RxList<Post> posts = <Post>[].obs;
  RxBool sneakyLoading = false.obs;
  RxBool isLoading = false.obs;

  // Logger
  final Logger _logger = Logger();

  @override
  onInit() {
    // Subscribe to reposities data stream
    _userRepository.users.listen((userList) {
      users.assignAll(userList);
      users.refresh();
    });

    _postRepository.posts.listen((postList) {
      posts.assignAll(postList);
    });
    super.onInit();
  }

  Future<void> seachUser(String username,
      {bool isLoadingDisabled = false}) async {
    if (!isLoadingDisabled) {
      isLoading.value = true;
    }
    try {
      await _userRepository.searchUsers(username);
    } catch (e) {
      _logger.e('Error searching  users: $e');
    }

    isLoading.value = false;
  }

  Future<void> loadMoreUsers() async {
    try {
      sneakyLoading.value = true;
      await _userRepository.loadMoreUser();
    } catch (e) {
      _logger.e('Error loading more recommended users: $e');
    }
    sneakyLoading.value = false;
  }

  Future<void> searchPost(String seachTerm,
      {bool isLoadingDisabled = false}) async {
    if (!isLoadingDisabled) {
      isLoading.value = true;
    }
    try {
      await _postRepository.searchPosts(seachTerm);
    } catch (e) {
      _logger.e('Error searching  posts: $e');
    }

    isLoading.value = false;
  }

  Future<void> loadMorePosts() async {
    try {
      sneakyLoading.value = true;
      await _postRepository.loadMorePost();
    } catch (e) {
      _logger.e('Error loading more posts: $e');
    }
    sneakyLoading.value = false;
  }
}
