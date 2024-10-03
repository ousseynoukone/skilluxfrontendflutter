import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/constant/constant.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/widgets/posts_renderer_list_view.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    PostFeedController _recommendedFeedController =
        Get.put(PostFeedController(feedType: FeedType.recommendedPosts));

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            APPNAME,
            style: themeText.headlineMedium,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          ],
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Divider(
                thickness: 0.1,
              )),
        ),
        body: PostsRendererListView(
          postFeedController: _recommendedFeedController,
        ));
  }
}
