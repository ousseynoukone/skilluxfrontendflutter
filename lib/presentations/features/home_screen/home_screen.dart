import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/sub_features/switch_feed_mod.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/widgets/posts_renderer_list_view.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/notification_icon.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  Widget build(BuildContext context) {
    var themeText = context.textTheme;
    HomePostService recommendedFeedController =
        Get.put(HomePostService(feedType: FeedType.recommendedPosts));

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            APPNAME,
            style: themeText.headlineMedium,
          ),
          actions: const [NotificationIcon()],
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Divider(
                thickness: 0.1,
              )),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: switchFeedMod(),
            ),
            Expanded(
              child: PostsRendererListView(
                homePostService: recommendedFeedController,
              ),
            ),
          ],
        ));
  }

  Widget switchFeedMod() {
    return const SwitchFeedMod();
  }
}
