import 'dart:ffi';

import 'package:flutter_fe/models/comment_model.dart';
import 'package:flutter_fe/models/verse_model.dart';

class Post{
  final String userName;
  final int userId;
  List<PostInfo>? posts;

  Post({
    required this.userName,
    required this.userId,
    this.posts
  });

  static List<Post> postss= 
  [
    Post(
      userName: 'aksza',
      userId: 1,
      posts: [
        PostInfo(
          postId: 1,
          userName: 'akszasuciu12',
          question: 'Who is God?',
          answer: 'God is God',
          userId: 1,
          profilePictureUrl: 'assets/images/aksza.jpeg',
          likesNum: 12,
          dislikesNum: 2,
          commentsNum: 0,
          anonym: false,
        )
      ]
    ),
    Post(
      userName: 'dani',
      userId: 2,
      posts: [
        PostInfo(
          postId: 2,
          userName: 'daniel',
          question: 'Who is Jesus?',
          answer: 'Jesus is God',
          userId: 2,
          profilePictureUrl: 'assets/images/dani.jpeg',
          likesNum: 23,
          dislikesNum: 5,
          commentsNum: 0,
          anonym: false,
        )
      ]
    ),
    Post(
      userName: 'peter',
      userId: 3,
      posts: [
        PostInfo(
          postId: 3,
          userName: 'peteredeti',
          question: 'Who am I according to the Bible?',
          answer: 'Gods son',
          userId: 3,
          profilePictureUrl: 'assets/images/peter.jpeg',
          likesNum: 54,
          dislikesNum: 9,
          commentsNum: 0,
          anonym: false,
        )
      ]
    )
  ];
}

class PostInfo{
  final int postId;
  String userName;
  String question;
  String answer;
  List<Verse>? verses;
  final int userId;
  final String profilePictureUrl;
  int likesNum;
  int dislikesNum;
  int commentsNum;
  final bool anonym;
  List<Comment>? comments;

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