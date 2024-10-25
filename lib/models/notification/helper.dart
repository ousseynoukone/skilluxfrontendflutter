import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/ressource.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:flutter/material.dart';

Widget formatNotificationDiplaying(List<UserDTO> userDTOs, String message,
    NotificationType type, Ressource? ressource) {
  var text = Get.context!.localizations;
  final themeText = Get.context!.textTheme;

  // Determine emoji and resource text based on notification type
  String emote;
  String? ressourceText;

  switch (type) {
    case NotificationType.vote:
      emote = "👍 ";
      ressourceText = ressource?.title;
      break;
    case NotificationType.commentLike:
      emote = "👍 ";
      ressourceText = ressource?.text;
      break;
    case NotificationType.comment:
      emote = "💬 ";
      ressourceText = ressource?.text;

      break;
    default:
      emote = "✅ ";
      ressourceText = ressource?.title;
  }

  // Start building the RichText
  List<TextSpan> spans = [TextSpan(text: emote)];

  // Add user names
  if (userDTOs.isNotEmpty) {
    for (int i = 0; i < userDTOs.length; i++) {
      spans.add(
        TextSpan(
          text: userDTOs[i].fullName,
          style: themeText.titleSmall!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      );

      // Add "and" or a comma for formatting
      if (i < userDTOs.length - 1) {
        spans.add(TextSpan(
          text: (userDTOs.length == 2) ? ' ${text.and} ' : ', ',
          style: themeText.titleSmall!.copyWith(fontSize: 14),
        ));
      }
    }

    // Append message
    spans.add(
      TextSpan(
        text: message,
        style: themeText.titleSmall!.copyWith(fontSize: 14),
      ),
    );

    // Append resource text if applicable
    if (ressourceText != null) {
      spans.add(
        TextSpan(
          text: ': "$ressourceText"',
          style: themeText.bodySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      );
    }
  }

  return RichText(text: TextSpan(children: spans));
}
