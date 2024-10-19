import 'package:intl/intl.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/ressource.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_ago_format.dart';
import 'package:skilluxfrontendflutter/presentations/features/helpers/time_format/time_format.dart';

class NotificationModel {
  final NotificationType type;
  final Ressource ressource;
  final String createdAtNotif;
  final String createdAt;
  final int count;
  final List<UserDTO> userDTOs;
  final String message;

  NotificationModel({
    required this.type,
    required this.ressource,
    required this.createdAtNotif,
    required this.count,
    required this.createdAt,
    required this.userDTOs,
    required this.message,
  });

  // Factory method to create a Notification from a Map (e.g., from JSON)
  factory NotificationModel.fromBody(Map<String, dynamic> json) {
    List<UserDTO> userDTOs = [];

    for (var user in json['users']) {
      userDTOs.add(UserDTO.fromJson(user));
    }
    DateTime createdAtNotif = DateTime.parse(json['notifCreatedAt']);
    String formattedDate =
        formatDateTimeHumanReadable(createdAtNotif, showHour: false);

    return NotificationModel(
        type: getNotificationType(json["type"]),
        ressource: Ressource.fromBody(json['ressource']),
        createdAtNotif: formattedDate,
        count: json['count'] as int,
        userDTOs: List.from(userDTOs),
        message: json['message'] as String,
        createdAt: getTimeAgoSync(createdAtNotif));
  }
}
