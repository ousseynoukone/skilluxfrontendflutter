import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';

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
