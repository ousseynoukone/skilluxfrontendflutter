import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

linearProgressingIndicator({bool inverseOrentiation = false}) {
  var colorScheme = Theme.of(Get.context!).colorScheme;

  return inverseOrentiation
      ? RotatedBox(
          quarterTurns: 2,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.width / 4,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: colorScheme.onSurface,
                color: colorScheme.primary,
              )),
        )
      : Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: Get.width / 4,
          height: 2,
          child: LinearProgressIndicator(
            backgroundColor: colorScheme.onSurface,
            color: colorScheme.primary,
          ));
}
