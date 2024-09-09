class CommentDto {
  final int? id;
  final String? text;
  final int? parentId;
  final int? postId;
  final int? userId;
  final int? targetId;
  final int? like;

  CommentDto({
    this.id,
    this.userId,
    this.text,
    this.parentId,
    this.postId,
    this.targetId,
    this.like,
  });

  // Convert the CommentDto to JSON
  Map<String, dynamic> toJson() {
    // Create a map and include only non-null values
    final jsonMap = <String, dynamic>{};

    if (id != null) {
      jsonMap['id'] = id;
    }
    if (text != null) {
      jsonMap['text'] = text;
    }
    if (parentId != null) {
      jsonMap['parentId'] = parentId;
    }
    if (postId != null) {
      jsonMap['postId'] = postId;
    }
    if (userId != null) {
      jsonMap['userId'] = userId;
    }
    if (targetId != null) {
      jsonMap['targetId'] = targetId;
    }
    if (like != null) {
      jsonMap['like'] = like;
    }

    return jsonMap;
  }

  // Convert JSON to a CommentDto instance
  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'] as int?,
      text: json['text'] as String?,
      parentId: json['parentId'] as int?,
      postId: json['postId'] as int?,
      userId: json['userId'] as int?,
      targetId: json['targetId'] as int?,
      like: json['like'] as int?,
    );
  }

  // Clone method with the ability to modify some attributes
  CommentDto clone({
    int? id,
    String? text,
    int? parentId,
    int? postId,
    int? userId,
    int? targetId,
    int? like,
  }) {
    return CommentDto(
      id: id ?? this.id,
      text: text ?? this.text,
      parentId: parentId ?? this.parentId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      targetId: targetId ?? this.targetId,
      like: like ?? this.like,
    );
  }
}
