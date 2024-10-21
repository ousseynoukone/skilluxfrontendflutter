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

  Widget basicNotif(NotificationType notifcationType) {
    String emote = notifcationType == NotificationType.vote ||
            notifcationType == NotificationType.commentLike
        ? "👍 "
        : "✅ ";

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
            title: Text(
              style: themeText.titleSmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              "$emote${widget.notification.message}",
            ),
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

  Widget commentNotif() {
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
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: widget.notification.message,
                    style: themeText.titleSmall!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: ' : " ${widget.notification.ressource?.text}"',
                    style: themeText.bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
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

  Widget renderNotif(NotificationModel notifcation) {
    switch (notifcation.type) {
      case NotificationType.vote ||
            NotificationType.post ||
            NotificationType.follow:
        return basicNotif(notifcation.type);

      case NotificationType.comment:
        return commentNotif();

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return renderNotif(widget.notification);
  }
}
