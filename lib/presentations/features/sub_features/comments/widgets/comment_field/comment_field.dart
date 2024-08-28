import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/user/user.dart';
import 'package:skilluxfrontendflutter/presentations/features/user_components/user_preview.dart';
import 'package:skilluxfrontendflutter/services/user_profile_services/user_profile_service.dart';

class CommentField extends StatefulWidget {
  const CommentField({super.key});

  @override
  State<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final UserProfileService _userProfileService = Get.find();

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
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          displayUserPP(_userProfileService.user?.profilePicture, radius: 25),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
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
            child: IconButton(
              hoverColor: Colors.transparent,
              onPressed: () {},
              icon: const Icon(Icons.send, size: 30),
            ),
          )
        ],
      ),
    );
  }
}
