import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/notification/grouped_notification.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';

import 'package:skilluxfrontendflutter/presentations/features/notification/helpers/helper.dart';
import 'package:logger/logger.dart';

class NotificationComponent extends StatefulWidget {
  final GroupedNotification groupedNotification;
  const NotificationComponent({super.key, required this.groupedNotification});

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  final themeText = Get.context!.textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;
  final Logger _logger = Logger();

  Widget notificationHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0, top: 6),
      child: Text(
        widget.groupedNotification.createdAt,
        style: themeText.titleSmall!
            .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget notificationBuilder() {
    return Column(
        children: widget.groupedNotification.notification
            .map((NotificationModel notification) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorScheme.primary),
          child: ListTile(
            leading: displayNotificationImage(notification, radius: 25),
            title: notification.messageWidget,
            subtitle: Text(
              notification.createdAt,
              style: themeText.bodySmall,
            ),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
          ),
        ),
      );
    }).toList());
  }

  Widget displayNotif() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        notificationHeader(),
        notificationBuilder(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return displayNotif();
  }
}
