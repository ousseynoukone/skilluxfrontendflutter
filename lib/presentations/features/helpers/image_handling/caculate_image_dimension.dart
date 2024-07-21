import 'dart:ui';

import 'package:get/get.dart';

Size calculateImageDimensions() {
  final screenWidth = Get.width;
  final screenHeight = Get.height;
  
  // Set the image to occupy 80% of the screen width
  final imageWidth = screenWidth * 0.8;
  
  // Calculate the height to maintain a 16:9 aspect ratio
  final imageHeight = imageWidth * 9 / 16;
  
  return Size(imageWidth, imageHeight);
}