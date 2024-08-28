import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class LikeAndReplyWidget extends StatefulWidget {
  final int initialLikes;
  final VoidCallback onReplyPressed;

  LikeAndReplyWidget({
    Key? key,
    required this.initialLikes,
    required this.onReplyPressed,
  }) : super(key: key);

  @override
  _LikeAndReplyWidgetState createState() => _LikeAndReplyWidgetState();
}

class _LikeAndReplyWidgetState extends State<LikeAndReplyWidget> {
  late int _numberOfLikes;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _numberOfLikes = widget.initialLikes;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _numberOfLikes--;
      } else {
        _numberOfLikes++;
      }
      _isLiked = !_isLiked;
    });
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
      likeText = "$_numberOfLikes ${text.likes}";
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
