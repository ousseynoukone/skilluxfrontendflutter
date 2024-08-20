import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/persistent_header_delegate.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/post_container.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/user_info.dart';
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/foreign_user_profile_service.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForeignProfileScreen extends StatefulWidget {
  final int foreignUserId;
  const ForeignProfileScreen({super.key, required this.foreignUserId});

  @override
  ForeignProfileScreenState createState() => ForeignProfileScreenState();
}

class ForeignProfileScreenState extends State<ForeignProfileScreen>
    with RouteAware {
  final Logger _logger = Logger();
  late ForeignUserPostsService _userProfilePostService;
  late ForeignUserProfileService _userProfileService;
  final AppLocalizations? text = Get.context?.localizations;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    _userProfileService =
        Get.put(ForeignUserProfileService(userId: widget.foreignUserId));
    _userProfilePostService =
        Get.put(ForeignUserPostsService(userId: widget.foreignUserId));
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

//While living this screen
  @override
  didPushNext() {}

  //If this screen pop again
  @override
  didPopNext() {
    _userProfilePostService.getUserPosts(disableLoading: true);
    _userProfileService.getUserInfos(disableLoading: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(text?.profile ?? 'Profile'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _userProfilePostService.getUserPosts();
          _userProfileService.getUserInfos();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            GetBuilder<ForeignUserProfileService>(builder: (controller) {
              return controller.obx(
                (state) => SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 260,
                  flexibleSpace: FlexibleSpaceBar(
                    background: UserInfo(
                      userInfoDto: state!,
                      isForOtherUser: true,
                    ),
                  ),
                ),
                onLoading: SliverToBoxAdapter(
                  child: Center(
                    child:
                        CircularProgressIndicator(color: colorScheme.onPrimary),
                  ),
                ),
                onError: (error) => SliverToBoxAdapter(
                  child: Center(child: Text(error!)),
                ),
                onEmpty: SliverToBoxAdapter(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: getCustomChip(
                          text?.noPostPosted ?? 'No Posts Posted', null,
                          isBackgroundTransparent: true)),
                ),
              );
            }),

            // Conditional inclusion of SliverPersistentHeader
            GetBuilder<ForeignUserPostsService>(
              builder: (controller) {
                if (controller.state != null) {
                  return SliverPersistentHeader(
                    delegate: PersistentHeaderDelegate(),
                    pinned: true,
                  );
                } else {
                  return SliverToBoxAdapter(child: Container());
                }
              },
            ),

            GetBuilder<ForeignUserPostsService>(builder: (controller) {
              return controller.obx(
                (state) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        PostContainer(post: state![index], isForOther: true),
                    childCount: state?.length ?? 0,
                  ),
                ),
                onLoading: SliverToBoxAdapter(
                  child: Center(
                    child:
                        CircularProgressIndicator(color: colorScheme.onPrimary),
                  ),
                ),
                onError: (error) => SliverToBoxAdapter(
                  child: Center(child: Text(error!)),
                ),
                onEmpty: SliverToBoxAdapter(
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: getCustomChip(
                          text?.noPostPosted ?? 'No Posts Posted', null,
                          isBackgroundTransparent: true)),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
