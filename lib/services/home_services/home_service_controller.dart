import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:skilluxfrontendflutter/core/api_service/api_service.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/home_service_repository.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/like_service.dart';

class HomePostService extends GetxController with StateMixin<List<Post>> {
  final APIService _apiService = Get.find();
  FeedType feedType;
  late final HomeServiceRepository _homeServiceRepository;
  final Logger _logger = Logger();
  final LikeService _likeService = Get.find();

  HomePostService({required this.feedType});

  // Observable variables
  final RxList<Post> recommendedPosts = <Post>[].obs;
  RxBool sneakyLoading = false.obs;

  @override
  void onInit() {
    _homeServiceRepository = HomeServiceRepository(feedType: feedType);
    super.onInit();
  }

  void switchFeedMod(FeedType feedType) {
    _homeServiceRepository.switchFeedMod(feedType);
    refreshFeed();
  }

  Future<void> getPosts({bool isLoadingDisabled = false}) async {
    if (!isLoadingDisabled) {
      change(null, status: RxStatus.loading());
    }
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
    _homeServiceRepository.reinititalizeParams();
    recommendedPosts.clear();
    getPosts();
  }

  void reinititalizeParams() {
    recommendedPosts.clear();
    sneakyLoading = false.obs;
    _homeServiceRepository.reinititalizeParams();
  }

  Future<bool> likePost(int postId) async {
    bool response = await _likeService.likePost(postId);
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
    bool response = await _likeService.unLikePost(postId);
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

  // LOCAL UPDATE SERVE TO UPDATE POST STATE BASED ON ACTIONS THAT HAVE BEEN DONE ELSEWHERE , IT HELP TO HAVE A SEAMLESS USER'S EXPERIENCE

  localUpdateIncrementCommentNumber(postId, {int number = 1}) {
    var post = recommendedPosts.firstWhereOrNull(
      (post) => post.id == postId,
    );
    // if (post != null) {
    post!.commentNumber += number;
    // }
    change(recommendedPosts, status: RxStatus.success());
  }

  localUpdateDecrementCommentNumber(postId, {int number = 1}) {
    var post = recommendedPosts.firstWhereOrNull(
      (post) => post.id == postId,
    );
    post!.commentNumber -= number;
    change(recommendedPosts, status: RxStatus.success());
  }
}
