import 'dart:ffi';

class Comment{
  final int commentId;
  final String userName;
  final String content;
  final int userId;
  final int postId;
  int likesNum;
  final String profilePictureUrl;
  final Bool author;

  Comment({
    required this.commentId,
    required this.userName,
    required this.content,
    required this.userId,
    required this.postId,
    required this.likesNum,
    required this.profilePictureUrl,
    required this.author
  });
}