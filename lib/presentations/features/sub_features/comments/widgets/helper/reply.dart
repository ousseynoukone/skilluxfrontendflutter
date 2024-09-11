import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/models/comment/comment.dart';
import 'package:skilluxfrontendflutter/models/comment/sub_models/commentDto.dart';
import 'package:skilluxfrontendflutter/presentations/features/sub_features/comments/widgets/comment_field/comment_field.dart';

// REMEMBER "comment"  IS THE UPPER COMMENT THAT YOU ARE GOING TO MAKE A RESPONSE
// SO IF parentId==null IT'S MEAN THE YOU ARE TRYING TO ANSWER THE DIRECT TOP LEVEL COMMEND , SO THE CHILD COMMENT SHOULD TAKE IT'S ID as "parentId" and the "targetId" should be null (it's a direct answer)
// ELSE IT MEANS THAT YOU ARE TRYING TO ANSWER A CHILD COMMENT  SO THE "parentId" MUST BE THE "parentId" OF THAT CHILD SINCE ALL CHILDREN SHARE THE SAME "parentId" and the "targetId" should be the userId of that Child comment
//
class ReplyButton extends StatelessWidget {
  final Comment comment;
  const ReplyButton({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    var text = context.localizations;
    var themeText = context.textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    void showCommentField() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CommentField(
              commentDTO: CommentDto(
                  postId: comment.postId!,
                  parentId: comment.parentId ?? comment.id,
                  targetId: comment.parentId == null ? null : comment.userId));
        },
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
      ),
      onPressed: () {
        showCommentField();
      },
      child: Text(
        text.reply,
        style: themeText.bodySmall?.copyWith(fontSize: 12),
      ),
    );
  }
}
