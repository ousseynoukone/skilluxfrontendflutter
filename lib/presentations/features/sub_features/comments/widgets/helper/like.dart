import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

class LikeAndReplyWidget extends StatefulWidget {
  final int initialLikes;
  final int commentId;
  final VoidCallback onReplyPressed;

  LikeAndReplyWidget({
    Key? key,
    required this.initialLikes,
    required this.commentId,
    required this.onReplyPressed,
  }) : super(key: key);

  @override
  _LikeAndReplyWidgetState createState() => _LikeAndReplyWidgetState();
}

class _LikeAndReplyWidgetState extends State<LikeAndReplyWidget> {
  late int _numberOfLikes;
  bool _isLiked = false;

  final CommentService _commentService = Get.find();

  @override
  void initState() {
    super.initState();
    _numberOfLikes = widget.initialLikes;
    _initializeLikeStatus();
  }

  Future<void> _initializeLikeStatus() async {
    final isLiked = await isElementAlreadyLiked(widget.commentId);
    setState(() {
      _isLiked = isLiked;
    });
  }

  void _toggleLike() async {
    final previousLikes = _numberOfLikes;
    final wasLiked = _isLiked;

    setState(() {
      if (_isLiked) {
        _numberOfLikes--;
        _isLiked = false;
      } else {
        _numberOfLikes++;
        _isLiked = true;
      }
    });

    final success = _isLiked
        ? await _commentService.likeComment(widget.commentId)
        : await _commentService.unLikeComment(widget.commentId);

    if (!success) {
      // Revert changes if the request fails
      setState(() {
        _numberOfLikes = previousLikes;
        _isLiked = wasLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    String likeText;
    if (_numberOfLikes == 0) {
      likeText = "";
    } else if (_numberOfLikes == 1) {
      likeText = text.oneLike;
    } else {
      likeText = "${formatLikes(_numberOfLikes)} ${text.likes}";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: ColorsTheme.primary,
          ),
          onPressed: _toggleLike,
        ),
        if (likeText.isNotEmpty)
          Flexible(
            child: Text(
              likeText,
              style: themeText.bodySmall?.copyWith(fontSize: 12),
              overflow: TextOverflow.visible, // Allows text to wrap
            ),
          ),
        const SizedBox(
            width: 16), // Add space between like count and reply button
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
          ),
          onPressed: widget.onReplyPressed,
          child: Text(
            text.reply,
            style: themeText.bodySmall?.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
