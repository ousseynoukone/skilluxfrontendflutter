import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget displayPostCoverPhoto(String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) {
    // Handle the case where the imageUrl is null or empty
    return const SizedBox.shrink();
  }

  return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
      ));
}
