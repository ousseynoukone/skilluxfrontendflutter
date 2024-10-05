import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/home_service_repository.dart';

class PostFeedController extends GetxController with StateMixin<List<Post>> {
  final APIService _apiService = Get.find();
  final FeedType feedType;
  late final HomeServiceRepository _homeServiceRepository;
  final Logger _logger = Logger();

  PostFeedController({required this.feedType});

  // Observable variables
  final RxList<Post> recommendedPosts = <Post>[].obs;
  RxBool sneakyLoading = false.obs;

  @override
  void onInit() {
    _homeServiceRepository = HomeServiceRepository(feedType: feedType);
    super.onInit();
    getPosts();
  }

  Future<void> getPosts() async {
    change(null, status: RxStatus.loading());
    try {
      final posts = await _homeServiceRepository.getPosts();
      if (posts.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        recommendedPosts.assignAll(posts);
        change(recommendedPosts, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e('Error fetching recommended posts: $e');
      change(null, status: RxStatus.error('Failed to load posts'));
    }
  }

  Future<void> loadMorePosts() async {
    try {
      sneakyLoading.value = true;
      final morePosts = await _homeServiceRepository.loadMorePosts();
      if (morePosts.isNotEmpty) {
        recommendedPosts.addAll(morePosts);
        change(recommendedPosts, status: RxStatus.success());
      }
    } catch (e) {
      _logger.e('Error loading more recommended posts: $e');
      change(recommendedPosts,
          status: RxStatus.error('Failed to load more posts'));
    }
    sneakyLoading.value = false;
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
        change(recommendedPosts, status: RxStatus.success());
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
        change(recommendedPosts, status: RxStatus.success());
      }
      return true;
    } else {
      return false;
    }
  }
}
