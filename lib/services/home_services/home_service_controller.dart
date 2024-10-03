// post_feed_controller.dart
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/home_service_repository.dart';

class PostFeedController extends GetxController {
  final APIService _apiService = Get.find();
  final FeedType feedType;
  late final HomeServiceRepository _homeServiceRepository;
  final Logger _logger = Logger();

  PostFeedController({required this.feedType});

  // Observable variables
  final RxList<Post> recommendedPosts = <Post>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;

  @override
  void onInit() {
    _homeServiceRepository = HomeServiceRepository(feedType: feedType);
    super.onInit();
    getPosts();
  }

  Future<void> getPosts() async {
    isLoading.value = true;
    try {
      final posts = await _homeServiceRepository.getPosts();
      recommendedPosts.assignAll(posts);
      hasMore.value = _homeServiceRepository.hasMorePosts;
    } catch (e) {
      _logger.e('Error fetching recommended posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMorePosts() async {
    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;
    try {
      final morePosts = await _homeServiceRepository.loadMorePosts();
      recommendedPosts.addAll(morePosts);
      hasMore.value = _homeServiceRepository.hasMorePosts;
    } catch (e) {
      _logger.e('Error loading more recommended posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void refreshFeed() {
    _homeServiceRepository.cursorPosts = "0";
    _homeServiceRepository.hasMorePosts = false;
    recommendedPosts.clear();
    getPosts();
  }

  Future<bool> likePost(int postId) async {
    bool response = await _homeServiceRepository.likePost(postId);
    if (response) {
      var index = recommendedPosts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        recommendedPosts[index].like();
        recommendedPosts.refresh();
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unLikePost(int postId) async {
    bool response = await _homeServiceRepository.unLikePost(postId);
    if (response) {
      var index = recommendedPosts.indexWhere((post) => post.id == postId);
      if (index != -1) {
        recommendedPosts[index].unlike();
        recommendedPosts.refresh();
      }
      return true;
    } else {
      return false;
    }
  }
}