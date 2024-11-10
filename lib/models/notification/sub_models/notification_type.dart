enum NotificationType { comment, post, vote, commentLike, follow }

getNotificationType(String value) {
  if (value == "comment") {
    return NotificationType.comment;
  }
  if (value == "like") {
    return NotificationType.commentLike;
  }
    if (value == "post") {
    return NotificationType.post;
  }

    if (value == "follow") {
    return NotificationType.follow;
  }

    if (value == "vote") {
    return NotificationType.vote;
  }
}
