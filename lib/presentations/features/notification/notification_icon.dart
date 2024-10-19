import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/preview/chip.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/notification_screen.dart';
import 'package:skilluxfrontendflutter/services/notification_services/server_side_event/nontification_sse.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({super.key});

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  final NotificationSse _notificationSse = Get.find();

  @override
  void initState() {
    super.initState();
    _notificationSse.connectToTheStream();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final notificationCount = _notificationSse.notificationCount.value;
      String notificationNumber =
          notificationCount > 99 ? "+99" : notificationCount.toString();

      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                Get.to(() => const NotificationScreen());
              },
              icon: const Icon(
                Icons.notifications,
              ), // Change icon color
            ),
            if (notificationCount > 0)
              Positioned(
                top: 4,
                right: 4,
                child: getCustomChip(notificationNumber, null,
                    isBackgroundTransparent: false,
                    fontSize: 13,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    backgroundColor: ColorsTheme.primary),
              ),
          ],
        ),
      );
    });
  }
}
