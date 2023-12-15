
import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/screens/home_screen.dart';
import 'package:flutter_fe/screens/login_screen.dart';
import 'package:flutter_fe/screens/message_screen.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/screens/register_screen.dart';
import 'package:flutter_fe/screens/search_screen.dart';
import 'package:flutter_fe/screens/splash_screen.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_fe/screens/post_screen.dart';



void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
    Map<String, WidgetBuilder> _getRoutes() {
    return {
      '/': (context) => const SplashScreenPage(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      ProfileScreen.routeName: (context) => const ProfileScreen(userId:2),
      SearchScreen.routeName: (context) => const SearchScreen(),
      MessageScreen.routeName: (context) => const MessageScreen(),
      PostScreen.routeName: (context) => PostScreen(post: PostInfo(
        id: 1, 
        question: "question",
        answer: "answer",
        anonym: false,
        userName: "userName", 
        userId: 2, 
        profilePictureUrl: "profilePictureUrl", 
        date: "date", 
        commentsNum: 2, 
        numLikes: 1, 
        numDisLikes: 2, 
        likedByUser: false, 
        dislikedByUser: false),
        user: User(
          userName: "userName",
          firstName: "firstName", 
          lastName: "lastName", 
          birthDate: "birthDate", 
          gender: false, 
          profilePictureUrl: "profilePictureUrl"),
      )
    };

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BibliAI',
      onGenerateRoute: (settings) {
        final routes = _getRoutes();
        final builder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => builder!(context));
      },
    );
      
  }
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}