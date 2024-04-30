import 'package:flutter_fe/models/post_model.dart';


class User{
  late String userName;
  late String firstName;
  late String profilePictureUrl;
  late String lastName;
  late String birthDate;
  late bool gender;
  bool? married;
  String? bios;
  String? religion;
  List<PostInfo>? posts;

  User({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    this.married,
    this.bios,
    this.religion,
    required this.profilePictureUrl,
    this.posts
  });

  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{};
    map["userName"] = userName;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["birthDate"] = birthDate;
    map["gender"] = gender;
    map["married"] = married;
    map["bios"] = bios;
    map["religion"] = religion;
    map["profilePictureUrl"] = profilePictureUrl;
    map["posts"] = posts?.map((post) => post.toMap()).toList();

    return map;
  }


  User.fromJson(dynamic o){
    this.userName = o["userName"] as String;
    this.firstName = o["firstName"] as String;
    this.lastName = o["lastName"] as String;
    this.birthDate = o["birthDate"] as String;
    this.gender = o["gender"] as bool;
    this.married = o["married"] as bool?;
    this.bios = o["bios"] as String;
    this.religion = o["religion"] as String;
    this.profilePictureUrl = o["profilePictureUrl"] as String;
    // this.posts = o["posts"] != null ? List<PostInfo>.from(o["posts"]) : null;
    if (o["posts"] != null) {
      this.posts = List<PostInfo>.from((o["posts"] as List).map((post) => PostInfo.fromJson(post)));
    } else {
      this.posts = [];
    }

  }
}
