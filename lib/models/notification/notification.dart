import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/ressource.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';

class Notification {
  final NotificationType type;
  final Ressource ressource;
  final DateTime createdAt;
  final int count;
  final UserDTO userDTO;
  final String message;

  Notification({
    required this.type,
    required this.ressource,
    required this.createdAt,
    required this.count,
    required this.userDTO,
    required this.message,
  });

  // Factory method to create a Notification from a Map (e.g., from JSON)
  factory Notification.fromBody(Map<String, dynamic> json) {
    return Notification(
      type: getNotificationType(json["type"]),
      ressource: Ressource.fromBody(json['ressource']),
      createdAt: DateTime.parse(json['createdAt']),
      count: json['count'] as int,
      userDTO: UserDTO.fromBody(json['userDTO']), 
      message: json['message'] as String,
    );
  }
}
