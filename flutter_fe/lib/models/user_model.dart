import 'dart:ffi';

import 'package:flutter_fe/models/post_model.dart';

class User{
  final UserInfo userInfo;
  List<PostInfo>? posts;

  User({
    required this.userInfo,
    this.posts
  });
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
  Bool gender;
  Bool? married;
  String? bio;
  String? religion;
  String? posts;

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
}

