import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';

Widget displayUserPreview(User u, {Widget? trailing}) {
  return ListTile(
    title: Text(u.fullName),
    leading: displayUserPP(u),
    trailing: trailing,
    subtitle: Text(u.profession ?? ""),
  );
}

Widget displayUserPP(User u) {
  if (u.profilePicture != null && u.profilePicture!.isNotEmpty) {

    return CircleAvatar(
      backgroundImage: NetworkImage(u.profilePicture!),
      radius: 20,
    );
  } else {
    return const CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 20,
      child: Icon(Icons.person, color: Colors.white),
    );
  }
}
