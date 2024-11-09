import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/constant/bottom_navigation_screen.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_post_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/search_screen.dart';
import 'package:skilluxfrontendflutter/services/home_services/home_service_controller.dart';
import 'package:skilluxfrontendflutter/services/home_services/repository/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class BottomNavigationBarComponent extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationBarComponent({super.key, this.initialIndex = 0});

  @override
  _BottomNavigationBarComponentState createState() =>
      _BottomNavigationBarComponentState();
}

class _BottomNavigationBarComponentState
    extends State<BottomNavigationBarComponent> {
  late UserProfilePostService userProfilePostService;
  late UserProfileService userProfileService;
  late HomePostService _homePostService;
  final RxInt _currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    userProfilePostService = Get.find<UserProfilePostService>();
    userProfileService = Get.find<UserProfileService>();
    _homePostService =
        Get.put(HomePostService(feedType: FeedType.recommendedPosts));

    // Set the initial index
    _currentIndex.value = widget.initialIndex;
  }

  @override
  void dispose() {
    // Clean up resources here
    _homePostService.reinititalizeParams(); // Dispose controller if needed
    _currentIndex.close(); // Dispose the RxInt to avoid memory leaks

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = context.localizations;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return Obx(() {
      _updateProfileIfNeeded();

      return Visibility(
        visible: !isKeyboardVisible,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SafeArea(
              child: IndexedStack(
                index: _currentIndex.value,
                children: bnScreensList,
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                height: 0.5,
                thickness: 0.1,
                color: colorScheme.outlineVariant,
              ),
              BottomAppBar(
                height: Get.height / 12.7,
                color: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildNavItem(Icons.home_outlined, Icons.home, text.home, 0,
                        colorScheme),
                    // _buildNavItem(
                    //     Icons.compass_calibration_outlined,
                    //     Icons.compass_calibration,
                    //     text.discovery,
                    //     1,
                    //     colorScheme),
                    _buildAddButton(colorScheme, text.post),
                    _buildSearchButton(colorScheme, text.search),
                    _buildNavItem(Icons.person_outline, Icons.person,
                        text.profile, 1, colorScheme),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _updateProfileIfNeeded() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentIndex.value == bnScreensList.length - 1) {
        userProfilePostService.getUserPosts(disableLoading: true);
        userProfileService.getUserInfos(disableLoading: true);
      }

      if (_currentIndex.value == 0) {
        _homePostService.getPosts(isLoadingDisabled: true);
      }
    });
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label,
      int index, ColorScheme colorScheme) {
    return InkWell(
      onTap: () => _currentIndex.value = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _currentIndex.value == index ? activeIcon : icon,
            color: _currentIndex.value == index
                ? colorScheme.onPrimary
                : colorScheme.primaryFixed,
            size: Get.width * 0.06,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex.value == index
                  ? colorScheme.onPrimary
                  : colorScheme.primaryFixed,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme, String label) {
    return InkWell(
      onTap: () => Get.to(() => const AddPostScreen()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            fill: 1,
            Icons.add,
            color: colorScheme.onPrimary,
            size: Get.width * 0.06,
          ),
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSearchButton(ColorScheme colorScheme, String label) {
  return InkWell(
    onTap: () => Get.to(() => const SearchScreen()),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          fill: 1,
          Icons.search,
          color: colorScheme.onPrimary,
          size: Get.width * 0.06,
        ),
        Text(
          label,
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
