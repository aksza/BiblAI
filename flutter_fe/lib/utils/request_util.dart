import 'package:http/http.dart' as http;

class RequestUtil{
  //ipcim:8000
  final endpoint = "http://192.168.1.2:8000/";

  Future<http.Response> getHome() async{
    return http.get(Uri.parse("${endpoint}home"));
  }

  Future<http.Response> getUserPosts(userId) {
    return http.get(Uri.parse("${endpoint}profile/{$userId}/posts"));
  }
}

