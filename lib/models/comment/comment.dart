class Comment {
  final int id;
  final String text;
  final bool isModified;
  final DateTime createdAt;
  int like;
  final int userId;
  final String? username;
  final String? fullName;
  final String? profilePicture;
  final int descendantCount;
  final int? postId;
  final int? parentId;
  final DateTime? updatedAt;

  Comment({
    required this.id,
    required this.text,
    required this.isModified,
    required this.createdAt,
    required this.like,
    required this.userId,
    this.username,
    this.fullName,
    this.profilePicture,
    this.descendantCount = 0,
    this.postId,
    this.parentId,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      isModified: json['isModified'],
      createdAt: DateTime.parse(json['createdAt']),
      like: json['like'],
      userId: json['userId'],
      username: json['username'],
      fullName: json['fullName'],
      profilePicture: json['profilePicture'],
      descendantCount: int.tryParse(json['descendantCount'] ?? '0') ?? 0,
      postId: json['postId'],
      parentId: json['parentId'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isModified': isModified,
      'createdAt': createdAt.toIso8601String(),
      'like': like,
      'userId': userId,
      'username': username,
      'fullName': fullName,
      'profilePicture': profilePicture,
      'descendantCount': descendantCount.toString(),
      'postId': postId,
      'parentId': parentId,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  likeComment() {
    like += 1;
  }
    unLikeComment() {
    like -= 1;
  }
  
  // Cloning method
  Comment clone() {
    return Comment(
      id: id,
      text: text,
      isModified: isModified,
      createdAt: createdAt,
      like: like,
      userId: userId,
      username: username,
      fullName: fullName,
      profilePicture: profilePicture,
      descendantCount: descendantCount,
      postId: postId,
      parentId: parentId,
      updatedAt: updatedAt,
    );
  }
}
