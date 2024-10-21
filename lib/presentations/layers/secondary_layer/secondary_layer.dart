import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/presentations/layers/secondary_layer/bottom_navigation_bar.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class SecondaryLayer extends StatefulWidget {
  final int? index;

  const SecondaryLayer({super.key, this.index});

  @override
  State<SecondaryLayer> createState() => _SecondaryLayerState();
}

class _SecondaryLayerState extends State<SecondaryLayer> {
  UserProfilePostService userProfilePostService =
      Get.put(UserProfilePostService());
  UserProfileService userProfileService = Get.put(UserProfileService());
  UserProfileFollowService service = Get.put(UserProfileFollowService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BottomNavigationBarComponent(
          initialIndex: widget.index ?? 0,
        ),
      ),
    );
  }
}
