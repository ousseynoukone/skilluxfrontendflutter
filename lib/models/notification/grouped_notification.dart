import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';

class GroupedNotification {
  final String createdAt;
  final List<NotificationModel> notification;
  GroupedNotification({required this.createdAt, required this.notification});
}
