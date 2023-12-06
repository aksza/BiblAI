import 'package:flutter_fe/models/post_model.dart';

// set pOSTS(List<PostInfo>? newPosts){
//     posts = newPosts;
//   }

//   void addPost(PostInfo newPost){
//     if(posts == null){
//       posts = [newPost];
//     }
//     else{
//       posts!.add(newPost);
//     }
//   }

class User{
  late String userName;
  late String firstName;
  String? profilePictureUrl;
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
    this.profilePictureUrl,
    this.posts
  });

  // String get userNAME => userName;
  // String get firstNAME => firstName;
  // String? get profilePictrureURL => profilePictureUrl;
  // String get lastNAME => lastName; 
  // String get birthDATE => birthDate;
  // bool get gENDER => gender;
  // bool? get mARRIED => married;
  // String? get bIO => bios;
  // String? get rELIGION => religion;
  // List<Post>? get pOSTS => posts;

  set profilePictureURL(String newURL){
    profilePictureUrl = newURL;
  }

  set bIO(String? newBio){
    bios = newBio;
  }
  
  set pOSTS(List<PostInfo>? newPosts){
    posts = newPosts;
  }

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
    this.posts = o["posts"] != null ? List<PostInfo>.from(o["posts"]) : null;
  }
}
