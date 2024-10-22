import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';

import 'package:skilluxfrontendflutter/presentations/features/notification/helpers/helper.dart';
import 'package:logger/logger.dart';

class NotificationComponent extends StatefulWidget {
  final NotificationModel notification;
  const NotificationComponent({super.key, required this.notification});

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  final themeText = Get.context!.textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;
  final Logger _logger = Logger();

  Widget displayNotif() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14.0, top: 6),
          child: Text(
            widget.notification.createdAtNotif,
            style: themeText.titleSmall!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorScheme.primary),
          child: ListTile(
            leading: displayNotificationImage(widget.notification, radius: 25),
            title: widget.notification.messageWidget,
            subtitle: Text(
              widget.notification.createdAt,
              style: themeText.bodySmall,
            ),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return displayNotif();
  }
}
