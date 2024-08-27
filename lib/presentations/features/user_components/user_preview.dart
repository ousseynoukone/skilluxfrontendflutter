import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

Widget displayUserPreview(User u, {Widget? trailing}) {
  return ListTile(
    title: Text(u.fullName),
    leading: displayUserPP(u.profilePicture),
    trailing: trailing,
    subtitle: Text(u.profession ?? ""),
  );
}

Widget displayUserPP(String? profilePicture, {double radius = 20}) {
  if (profilePicture != null && profilePicture.isNotEmpty) {
    return CircleAvatar(
      backgroundImage: NetworkImage(profilePicture),
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
