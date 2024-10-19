import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/widgets/display_section/display_image.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_format.dart';
import 'package:skilluxfrontendflutter/presentations/features/notification/helpers/helper.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';

class NotificationComponent extends StatefulWidget {
  final NotificationModel notification;
  const NotificationComponent({super.key, required this.notification});

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  final themeText = Get.context!.textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;

  Widget likeNotif() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14.0, top: 6),
          child: Text(
            widget.notification.createdAtNotif,
            style: themeText.titleSmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: colorScheme.primary),
          child: ListTile(
            leading: displayNotificationImage(widget.notification, radius: 25),
            title: Text(
              "👍 ${widget.notification.message}",
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
      case NotificationType.post:
        return likeNotif();

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return likeNotif();
  }
}
