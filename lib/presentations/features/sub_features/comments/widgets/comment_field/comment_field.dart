import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/presentations/shared_widgets/icon_button.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class CommentField extends StatefulWidget {
  final CommentDto commentDTO;

  const CommentField({super.key, required this.commentDTO});

  @override
  State<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  final TextEditingController _commentTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final UserProfileService _userProfileService = Get.find();
  final CommentService _commentService = Get.find();

  @override
  void initState() {
    super.initState();
    // Request focus to open the keyboard automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _commentTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          displayUserPP(_userProfileService.user?.profilePicture, radius: 25),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              style:
                  textTheme.bodySmall?.copyWith(color: colorScheme.onSurface),
              controller: _commentTextController,
              focusNode: _focusNode,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                hintText: text.makeComment,
                contentPadding: const EdgeInsets.all(8.0),
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorScheme.primary),
            child: Obx(
              () => CustomIconButton(
                  onPressed: () {
                    String text = _commentTextController.text.trim();
                    if (text.isNotEmpty) {
                      CommentDto comment = widget.commentDTO.clone(text: text);
                      _commentService.addComment(comment);
                    }
                  },
                  isLoading: _commentService.isAddingCommentLoading.value,
                  icon: Icons.send,
                  overideIconSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
