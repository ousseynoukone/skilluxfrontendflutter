import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/persistent_header_delegate.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/post_container.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/user_info.dart';
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/foreign_user_profile_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForeignProfileScreen extends StatefulWidget {
  final int foreignUserId;

  ForeignProfileScreen({super.key, required this.foreignUserId});

  @override
  _ForeignProfileScreenState createState() => _ForeignProfileScreenState();
}

class _ForeignProfileScreenState extends State<ForeignProfileScreen>
    with RouteAware {
  late final ForeignUserProfileService _userProfileService;
  late final ForeignUserPostsService _userPostsService;
  final ScrollController _scrollController = ScrollController();
  final Logger _logger = Logger();
  bool isPostLoading = false;
  bool isPostEmpty = false;

  @override
  void initState() {
    super.initState();
    _userProfileService =
        ForeignUserProfileService(userId: widget.foreignUserId);
    _userPostsService = ForeignUserPostsService(userId: widget.foreignUserId);
    _userProfileService.getUserInfos();
    _userPostsService.getUserPosts();
    _scrollController.addListener(_scrollListener);
    _isPostLoadingOrEmpty();
  }

  void _isPostLoadingOrEmpty() {
    _userPostsService.isLoading.listen((onData) {
      setState(() {
        isPostLoading = onData;
      });
    });

    _userPostsService.isEmpty.listen((onData) {
      setState(() {
        isPostEmpty = onData;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() {
    _userPostsService.loadMoreUserPosts(
        userId: widget.foreignUserId, disableLoading: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPushNext() {}

  @override
  void didPopNext() {
    _userPostsService.getUserPosts(disableLoading: true);
    _userProfileService.getUserInfos(disableLoading: true);
  }

  @override
  void dispose() {
    _userPostsService.dispose();
    _userProfileService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final AppLocalizations? text = context.localizations;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(text?.profile ?? 'Profile'),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          StreamBuilder<User?>(
            stream: _userProfileService.userInfoStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 260,
                  flexibleSpace: FlexibleSpaceBar(
                    background: UserInfo(
                      userId: widget.foreignUserId,
                      userInfoDto: snapshot.data!,
                      isForOtherUser: true,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(snapshot.error.toString())),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    height: Get.height / 1.5,
                    alignment: Alignment.center,
                    child:
                        CircularProgressIndicator(color: colorScheme.onPrimary),
                  ),
                );
              }
            },
          ),
          StreamBuilder<List<Post>?>(
            stream: _userPostsService.postsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverPersistentHeader(
                  delegate: PersistentHeaderDelegate(),
                  pinned: true,
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(snapshot.error.toString())),
                );
              } else {
                return SliverToBoxAdapter(child: Container());
              }
            },
          ),
          StreamBuilder<List<Post>?>(
            stream: _userPostsService.postsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PostContainer(
                      post: snapshot.data![index],
                      isForOther: true,
                    ),
                    childCount: snapshot.data?.length ?? 0,
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(snapshot.error.toString())),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    height: Get.height / 1.5,
                    alignment: Alignment.center,
                    child:
                        CircularProgressIndicator(color: colorScheme.onPrimary),
                  ),
                );
              }
            },
          ),
          isPostEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        text!.noPostPosted,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ),
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
          isPostLoading
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: colorScheme.onPrimary)),
                  ),
                )
              : const SliverToBoxAdapter(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
