import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/notification/notification.dart';
import 'package:skilluxfrontendflutter/models/notification/sub_models/notification_type.dart';
import 'package:skilluxfrontendflutter/models/user/dtos/user_dto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

Widget displayUserPreview(dynamic user,
    {Widget? trailing, bool zeroPadding = false}) {
  String fullName = "";
  String? profilePicture;
  String? profession;

  // Retrieve localizations and text theme
  final text = Get.context!.localizations;
  final textTheme = Theme.of(Get.context!).textTheme;
  final colorScheme = Theme.of(Get.context!).colorScheme;

  // Check if user is UserDTO or User and extract data
  if (user is UserDTO) {
    fullName = user.fullName;
    profilePicture = user.profilePicture;
    profession = user.profession;
  } else if (user is User) {
    fullName = user.fullName;
    profilePicture = user.profilePicture;
    profession = user.profession;
  }
  return ListTile(
    contentPadding: zeroPadding == false
        ? const EdgeInsets.symmetric(horizontal: 16)
        : const EdgeInsets.all(0),
    title: Text(fullName),
    leading: displayUserPP(profilePicture),
    trailing: trailing,
    subtitle: Text(
      profession ?? "",
      style: textTheme.bodySmall,
    ),
  );
}

Widget displayUserPP(String? profilePicture, {double? radius}) {
  final mediaQuery = MediaQuery.of(Get.context!);
  final defaultRadius = min(30.0, mediaQuery.size.width * 0.12);

  if (profilePicture != null && profilePicture.isNotEmpty) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(profilePicture),
      radius: radius ?? defaultRadius,
    );
  } else {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: radius ?? defaultRadius,
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: (radius ?? defaultRadius) * 1.5,
      ),
    );
  }
}
