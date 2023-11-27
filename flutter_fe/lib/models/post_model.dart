import 'dart:ffi';

import 'package:flutter_fe/models/comment_model.dart';
import 'package:flutter_fe/models/verse_model.dart';

class Post{
  final String userName;
  final int postNum;
  List<PostInfo>? posts;

  Post({
    required this.userName,
    required this.postNum,
    this.posts
  });
}

class PostInfo{
  final int postId;
  String userName;
  String question;
  String answer;
  List<VerseInfo>? verses;
  final int userId;
  final String profilePictureUrl;
  int likesNum;
  int dislikesNum;
  int commentsNum;
  final Bool anonym;
  List<CommentInfo>? comments;

  PostInfo({
    required this.postId,
    required this.userName,
    required this.question,
    required this.answer,
    this.verses,
    required this.userId,
    required this.profilePictureUrl,
    required this.likesNum,
    required this.dislikesNum,
    required this.commentsNum,
    required this.anonym,
    this.comments
  });
  
}