import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/models/post/post.dart';
import 'package:skilluxfrontendflutter/presentations/features/add_post_screen/post_view.dart';
import 'package:skilluxfrontendflutter/services/mainHelpers/comment_post_provider/comment_post_provider.dart';
import 'package:skilluxfrontendflutter/services/post_service_annexe/post_service.dart';

Widget displayNotificationImage(NotificationModel notification,
    {double radius = 20}) {
  if (notification.type == NotificationType.post) {
    if (notification.ressource!.headerImage != null &&
        notification.ressource!.headerImage!.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(notification.ressource!.headerImage!),
        radius: radius,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        radius: radius,
        child: Icon(
          Icons.image,
          color: Colors.white,
          size: radius * 1.5,
        ),
      );
    }
  } else {
    if (notification.userDTOs.first.profilePicture != null &&
        notification.userDTOs.first.profilePicture!.isNotEmpty) {
      return CircleAvatar(
        backgroundImage:
            NetworkImage(notification.userDTOs.first.profilePicture!),
        radius: radius,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        radius: radius,
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: radius * 1.5,
        ),
      );
    }
  }
}

