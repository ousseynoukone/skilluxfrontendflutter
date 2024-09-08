import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/confirm_dialog.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/icon_button.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/outline_button.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

Widget displayDeleteCommentButton(Comment comment) {
  final CommentService commentService = Get.find();
  UserProfileService userProfileService = Get.find();
  User user = userProfileService.user!;
  var colorScheme = Theme.of(Get.context!).colorScheme;
  var text = Get.context?.localizations;


  return user.id == comment.userId
      ? Obx(() => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: colorScheme.primaryContainer),
            child: CustomIconButton(
                padding: const EdgeInsets.all(4),
                overideIconSize: 23,
                icon: Icons.delete_outline,
                iconColor: ColorsTheme.primary,
                onPressed: () {
                  Get.dialog(ConfirmationDialog(
                      title: text!.confirmation,
                      content: text.confirm,
                      onConfirm: () {
                        commentService.deleteComment(comment.id);
                      }));
                },
                isLoading: commentService.isCommentLoading.value),
          ))
      : const SizedBox.shrink();
}
