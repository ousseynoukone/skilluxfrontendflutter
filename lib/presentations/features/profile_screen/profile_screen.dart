import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/poppup_menu_button.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/persistent_header_delegate.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/sub_widget/post_container.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/widgets/user_info.dart';
import 'package:skilluxfrontendflutter/services/system_services/route_observer_utils/route_observer_utils.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  final Logger _logger = Logger();
  final UserProfilePostService userProfilePostService = Get.find();
  final UserProfileService userProfileService = Get.find();
  final AppLocalizations? text = Get.context?.localizations;
  final ScrollController _scrollController = ScrollController();



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // We have reached the end of the list
      userProfilePostService.loadMoreUserPost(disableLoading: true);
    }
  }

//While living this screen
  @override
  didPushNext() {}

  //If this screen pop again
  @override
  didPopNext() {
    userProfilePostService.getUserPosts(disableLoading: true);
    userProfileService.getUserInfos(disableLoading: true);
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
        automaticallyImplyLeading: false, // Remove back button in appbar
        centerTitle: true,
        title: Text(text?.profile ?? 'Profile'),
        actions: const [PoppupMenuButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          userProfilePostService.getUserPosts();
          userProfileService.getUserInfos();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            GetBuilder<UserProfileService>(builder: (controller) {
              return controller.obx(
                (state) => SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 260,
                  flexibleSpace: FlexibleSpaceBar(
                    background: UserInfo(
                      userInfoDto: state!,
                    ),
                  ),
                ),
                onLoading: SliverToBoxAdapter(
                  child: Container(
                    height: Get.height / 1.5,
                    alignment: Alignment.center,
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
            GetBuilder<UserProfilePostService>(
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

            GetBuilder<UserProfilePostService>(builder: (controller) {
              return controller.obx(
                (state) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PostContainer(post: state![index]),
                    childCount: state?.length ?? 0,
                  ),
                ),
                onLoading: SliverToBoxAdapter(
                  child: Container(
                    height: Get.height / 1.5,
                    alignment: Alignment.center,
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
