import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class RequestUtil{
  //emulatornak a host-ja
  final endpoint = "10.0.3.2:7060";

  //get request
  Future<http.Response> getPost(int userId) async {
    try{
      return http.get(Uri.https(endpoint, "/api/Post/$userId"));
    } catch(error){
      Logger().e("Error in getPost function: $error");
      rethrow; //ujravetites az eredeti kivetelhez
    }
  }

  Future<http.Response> getUser(int userId) async {
    try{
      return http.get(Uri.https(endpoint, "/api/User/$userId"));
    } catch(error){
      Logger().e("Error in getUser function: $error");
      rethrow; //ujravetites az eredeti kivetelhez
    }
  }

  //post
  Future<void> postComment(String content, int userId, int postId, String date) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Comment/create");
      await http.post(
        url,
        body: jsonEncode({
          'content': content,
          'userId': userId,
          'postId': postId,
          'date': date,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in postComment: $error");
      rethrow;
    }

  }

  Future<void> postCommentLike(bool type, int userId, int commentId) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Comment/like");
      await http.post(
        url,
        body: jsonEncode({
          'type': type,
          'userId': userId,
          'commentId': commentId,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in postCommentLike: $error");
      rethrow;
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

  Future<void> postCreatePost(String question,String answer, bool anonym, int userId, String date) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Post/create");
      await http.post(
        url,
        body: jsonEncode({
          'question': question,
          'answer' : answer,
          'anonym' : anonym,
          'userId': userId,
          'date': date,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in postCreatePost: $error");
      rethrow;
    }
  }

  Future<void> postLikePost(bool type, int userId, int commentId) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Post/like");
      await http.post(
        url,
        body: jsonEncode({
          'type': type,
          'userId': userId,
          'commentId': commentId,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in postLikePost: $error");
      rethrow;
    }
  }

  Future<void> postUserCreate(String userName,String firstName, String lastName, String email, String password, String profilePictureUrl, String birthDate, bool gender, bool married, String bio, String religion) async {
    try{
      final url = Uri.parse("https://$endpoint/api/User/create");
      await http.post(
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
    }catch(error){
      Logger().e("Error in postComment: $error");
      rethrow;
    }

  }


  //delete
  Future<void> deleteCommentById(int commentId) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Comment/$commentId");
      await http.delete(url);
    }catch(error){
      Logger().e("Error in deleteComment: $error");
      rethrow;
    }
  }


//hogy kell?
  // Future<void> deleteCommentUnlike(int userId,int commentId) async {
  //   try{
  //     final url = Uri.parse("https://$endpoint/api/Comment/unlike");
  //     await http.delete(url);
  //   }catch(error){
  //     Logger().e("Error in deleteCommentUnlike: $error");
  //     rethrow;
  //   }
  // }

  //post/unlike


  //put 

  Future<void> putCommentUpdateLike(int userId,int commentId) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Comment/update_like");
      await http.put(
        url,
        body: jsonEncode({
          'userId': userId,
          'commentId': commentId
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in putCommentUpdateLike: $error");
      rethrow;
    }
  }

  Future<void> putPostUpdateLike(int userId,int postId) async {
    try{
      final url = Uri.parse("https://$endpoint/api/Comment/update_like");
      await http.put(
        url,
        body: jsonEncode({
          'userId': userId,
          'commentId': postId
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }catch(error){
      Logger().e("Error in putPostUpdateLike: $error");
      rethrow;
    }
  }


  // Future<http.Response> getUserPosts(userId) {
  //   return http.get(Uri.parse("${endpoint}profile/{$userId}/posts"));
  // }
}