import 'dart:ffi';

import 'package:flutter_fe/models/post_model.dart';

class User{
  final UserInfo userInfo;
  List<PostInfo>? posts;

  User({
    required this.userInfo,
    this.posts
  });

  static List<User> users = 
  [
    User(
      userInfo: UserInfo(
        birthDate: '2002.09.18',
        userId: 1,
        userName: 'akszasuciu12',
        firstName: 'Aksza',
        lastName: 'Suciu',
        profilePictureUrl: 'assets/images/aksza.jpeg',
        email: 'suciuaksza12@gmail.com',
        password: 'akszavagyok12',
        gender: true,
        married: false,
        bio: 'aksza vagyok sziasztok',
        religion: 'karizmatikus',
        posts: null
      ),
      posts: null
    ),
    User(
      userInfo: UserInfo(
        birthDate: '2002.04.28',
        userId: 2,
        userName: 'szoverfidani',
        firstName: 'Dani',
        lastName: 'Szoverfi',
        profilePictureUrl: 'assets/images/dani.jpeg',
        email: 'szoverfidani@gmail.com',
        password: 'daniprofil123',
        gender: false,
        married: true,
        bio: 'dani vagyok hello',
        religion: 'reformatus',
        posts: null
      ),
      posts: null
    ),
    User(
      userInfo: UserInfo(
        birthDate: '2003.06.09',
        userId: 3,
        userName: 'peteredeti',
        firstName: 'Peter',
        lastName: 'Simon',
        profilePictureUrl: 'assets/images/peter.jpeg',
        email: 'petersimon@gmail.com',
        password: 'peterposztok321',
        gender: false,
        married: false,
        bio: 'peteredeti vok hello',
        religion: 'presbiterianus',
        posts: null
      ),
      posts: null
    )
  ];
}

class UserInfo{
  final int userId;
  String userName;
  String firstName;
  String? profilePictureUrl;
  String lastName;
  String email;
  String password;
  String birthDate;
  bool gender;
  bool? married;
  String? bio;
  String? religion;
  List<Post>? posts;

  UserInfo({
    required this.userId,
    required this.userName,
    required this.firstName,
    this.profilePictureUrl,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.gender,
    this.married,
    this.bio,
    this.religion,
    this.posts
  });

  String getUsername(userId){
    if(userId == this.userId){
      return userName;
    }
    return 'username not found';
  }
}

