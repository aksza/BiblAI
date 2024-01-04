import 'dart:convert';

import 'package:flutter_fe/models/verse_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_fe/auth/db_service.dart';

class RequestUtil{
  //emulatornak a host-ja
  final endpoint = "10.0.3.2:7060";
  // late SharedPreferences prefs;

  //get request

  // Future<http.Response> getPost(int userId) async {
  //   try{
  //     return http.get(Uri.https(endpoint, "/api/Post/$userId"));
  //   } catch(error){
  //     Logger().e("Error in getPost function: $error");
  //     rethrow; //ujravetites az eredeti kivetelhez
  //   }
  // }

  Future<http.Response> getPostPublic() async {
    try{
      return http.get(Uri.https(endpoint, "/api/Post/public"));
    } catch(error){
      Logger().e("Error in getPost function: $error");
      rethrow; 
    }
  }
  

  Future<http.Response> getPostPrivate() async {
    String? token = await DatabaseProvider().getToken();

    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
       try{
        final response =await http.get(
                      Uri.https(endpoint, "/api/Post/private"),
                      headers: headers
                      );
        return response;
        } catch(error){
        Logger().e("Error in getPost function: $error");
        rethrow;
      }
    }
    else{
      throw Exception("There is no saved token");
    }
  }


  Future<http.Response> getUser(int userId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{

        return http.get(Uri.https(endpoint, "/api/User/$userId"),
                        headers: headers);
      } catch(error){
        Logger().e("Error in getUser function: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }

  Future<http.Response> getPostSearch(String search) async {
    try{
      return http.get(Uri.https(endpoint, "/api/Post/$search"));

    } catch(error){
      Logger().e("Error in getPost function: $error");
      rethrow; 
    }
  }

  //post
  Future<void> postComment(String content, int userId, int postId, String date) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
      try{
        final url = Uri.parse("https://$endpoint/api/Comment/create");
        var res = await http.post(
          url,
          body: jsonEncode(
            {
              "content": content,
              "userId": userId,
              "postId": postId,
              "date": date
            }
          ),
          headers: headers,
        );
        Logger().i(res.body);
      } catch(error) {
        Logger().e("Error in postComment: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }

  }

  Future<void> postCommentLike(bool type, int userId, int commentId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{
        final url = Uri.parse("https://$endpoint/api/Comment/like");
        await http.post(
          url,
          body: jsonEncode({
            "type": type,
            "userId": userId,
            "commentId": commentId,
          }),
          headers: headers,
        );
      }catch(error){
        Logger().e("Error in postCommentLike: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");

    }
  }

  Future<void> postAnswer(String question, String length, int numVerses) async {
    
    try{
      final url = Uri.parse("https://$endpoint/api/Post/get_answer");
      await http.post(
        url,
        body: jsonEncode({
          'question': question,
          'length': length,
          'num_verses': numVerses,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in postAnswer: $error");
      rethrow;
    }
    
  }

  Future<void> postCreatePost(String question,String answer,String content, bool anonym, int userId, String date,List<Verse> verses ) async {
    
    String? token = await DatabaseProvider().getToken();
    Logger().i(token);
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
      
      try{
        final url = Uri.parse("https://$endpoint/api/Post/create");
        var res = await http.post(
          url,
          body: jsonEncode({
            'question': question,
            'answer' : answer,
            'content' : content,
            'anonym' : anonym,
            'userId': userId,
            'date': date,
            'verses': verses.map((verse) => {
              'book': verse.book,
              'chapter': verse.chapter,
              'vers': verse.verse,
              }).toList(),
          }),
          headers: headers,
        );
      }catch(error){
        Logger().e("Error in postCreatePost: $error");
        rethrow;
      }
    }
    else{
      throw Exception("There is no saved token");
    }
  }

  Future<void> postLikePost(bool type, int userId, int commentId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
      
      try{
        final url = Uri.parse("https://$endpoint/api/Post/like");
        var res = await http.post(
          url,
          body: jsonEncode({
            "type": type,
            "userId": userId,
            "commentId": commentId,
          }),
          headers: headers,
        );
        Logger().i(res.body);
      }catch(error){
        Logger().e("Error in postLikePost: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }

  Future<void> postUserCreate(String userName,String firstName, String lastName, String email, String password, String profilePictureUrl, String birthDate, bool gender, bool married, String bio, String religion) async {
    try{
      final url = Uri.parse("https://$endpoint/api/User/create");
      final response = await http.post(
        url,
        body: jsonEncode({
          'userName': userName,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password' : password,
          'profilePictureUrl' : profilePictureUrl,
          'birthDate' : birthDate,
          'gender' : gender,
          'married' : married,
          'bios' : bio,
          'religion' : religion
        }),
        headers: {'Content-Type': 'application/json'},
      );
      Logger().i("Response status code: ${response.statusCode}");
      Logger().i("Response body: ${response.body}");
    }catch(error){
      Logger().e("Error in User create: $error");
      rethrow;
    }

  }

  Future<http.Response> postUserLogin(String userName,String password) async {
    try{
      http.Response resp;
      final url = Uri.parse("https://$endpoint/api/User/login");
      resp = await http.post(
        url,
        body: jsonEncode({
          'userName': userName,
          'password' : password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      return resp;
    }catch(error){
      Logger().e("Error in Login: $error");
      rethrow;
    }
  }


  //delete
  Future<void> deleteCommentById(int commentId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{
        final url = Uri.parse("https://$endpoint/api/Comment/$commentId");
        await http.delete(url,headers: headers);
      }catch(error){
        Logger().e("Error in deleteComment: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }


  Future<void> deleteCommentUnlike(int userId,int commentId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{
        final url = Uri.parse("https://$endpoint/api/Comment/unlike");
        await http.delete(
          url,
          headers:headers,
          body: jsonEncode({
            "userId": userId,
            "commentId": commentId,
          }),
        );
      }catch(error){
        Logger().e("Error in deleteCommentUnlike: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }

  //post/unlike
  Future<void> deletePostUnlike(int userId,int postId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{
        final url = Uri.parse("https://$endpoint/api/Post/unlike");
        await http.delete(
          url,
          headers: headers,
          body: jsonEncode({
            "userId": userId,
            "commentId": postId,
          }),
        );
      }catch(error){
        Logger().e("Error in deletePosttUnlike: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }

  //put 

  Future<void> putCommentUpdateLike(int userId,int commentId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{
        final url = Uri.parse("https://$endpoint/api/Comment/update_like");
        await http.put(
          url,
          body: jsonEncode({
            'userId': userId,
            'commentId': commentId
          }),
          headers: headers
        );
      }catch(error){
        Logger().e("Error in putCommentUpdateLike: $error");
        rethrow;
      }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }

  Future<void> putPostUpdateLike(int userId,int postId) async {
    String? token = await DatabaseProvider().getToken();
    if(token != null){
      var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

      try{
        final url = Uri.parse("https://$endpoint/api/Post/update_like");
        await http.put(
          url,
          body: jsonEncode({
            'userId': userId,
            'commentId': postId
          }),
          headers: headers
        );
      }catch(error){
        Logger().e("Error in putPostUpdateLike: $error");
        rethrow;
    }
    }
    else{
      throw Exception("Ther is no saved token");
    }
  }

  // Future<void> saveToken(String token) async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setString('token', token);
  // }

  // Future<String?> getToken() async {
  //   prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

}