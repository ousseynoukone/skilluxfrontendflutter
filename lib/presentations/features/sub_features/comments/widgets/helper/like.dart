import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/helper/helper.dart';
import 'package:skilluxfrontendflutter/services/comment_services/comment_service.dart';

// Abstract LikeWidget that can be used for different likeable elements
class LikeWidget extends StatefulWidget {
  final int initialLikes;
  final int elementId;
  final Future<bool> Function(int) likeFunction;
  final Future<bool> Function(int) unlikeFunction;
  final Future<bool> Function(int) isLikedFunction;

  const LikeWidget({
    Key? key,
    required this.initialLikes,
    required this.elementId,
    required this.likeFunction,
    required this.unlikeFunction,
    required this.isLikedFunction,
  }) : super(key: key);

  @override
  _LikeWidgetState createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  late int _numberOfLikes;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _numberOfLikes = widget.initialLikes;
    _initializeLikeStatus();
  }

  Future<void> _initializeLikeStatus() async {
    final isLiked = await widget.isLikedFunction(widget.elementId);
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
        ? await widget.likeFunction(widget.elementId)
        : await widget.unlikeFunction(widget.elementId);

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

    String likeText;
    if (_numberOfLikes == 0) {
      likeText = "";
    } else if (_numberOfLikes == 1) {
      likeText = text.oneLike;
    } else {
      likeText = "${formatLikes(_numberOfLikes)} ${text.likes}";
    }

    return Row(
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
              overflow: TextOverflow.visible,
            ),
          ),
      ],
    );
  }
}



