import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/constant/bottom_navigation_screen.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/add_post_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/discovery_screen/discovery_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/home_screen/home_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/profile_screen/profile_screen.dart';
import 'package:skilluxfrontendflutter/presentations/features/search_screen/search_screen.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class BottomNavigationBarComponent extends StatefulWidget {
  final int? index;
  const BottomNavigationBarComponent({super.key, this.index});

  @override
  State<BottomNavigationBarComponent> createState() =>
      _BottomNavigationBarComponentState();
}

class _BottomNavigationBarComponentState
    extends State<BottomNavigationBarComponent> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    _currentIndex = widget.index ?? 0;

    UserProfilePostService userProfilePostService = Get.find();
    UserProfileService userProfileService = Get.find();

    var text = context.localizations;
    if (_currentIndex == 3) {
      userProfilePostService.getUserPosts(disableLoading: true);
      userProfileService.getUserInfos(disableLoading: true);
    }

    return Scaffold(
      body: bnScreensList[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            height: 1,
            thickness: 0.1,
            color: colorScheme.outlineVariant,
          ),
          BottomAppBar(
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(
                    Icons.home_outlined, Icons.home, text.home, 0, colorScheme),
                _buildNavItem(Icons.compass_calibration_outlined,
                    Icons.compass_calibration, text.discovery, 1, colorScheme),
                _buildAddButton(colorScheme),
                _buildNavItem(Icons.search_outlined, Icons.search, text.search,
                    2, colorScheme),
                _buildNavItem(Icons.person_outline, Icons.person, text.profile,
                    3, colorScheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label,
      int index, ColorScheme colorScheme) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      enableFeedback: false,
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: Get.width * 0.05,
            _currentIndex == index ? activeIcon : icon,
            color: _currentIndex == index
                ? colorScheme.onPrimary
                : colorScheme.primaryFixed,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index
                  ? colorScheme.onPrimary
                  : colorScheme.primaryFixed,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      enableFeedback: false,
      onTap: () => Get.to(() => const AddPostScreen()),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add_circle_rounded,
            color: colorScheme.onPrimary, size: 40),
      ),
    );
  }
}
