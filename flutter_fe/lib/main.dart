import 'package:flutter/material.dart';
import 'package:flutter_fe/screens/home_screen.dart';
import 'package:flutter_fe/screens/login_screen.dart';
import 'package:flutter_fe/screens/message_screen.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/screens/register_screen.dart';
import 'package:flutter_fe/screens/search_screen.dart';
import 'package:flutter_fe/screens/splash_screen.dart';
import 'dart:io';
import 'package:http/http.dart' as http;



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
      ProfileScreen.routeName: (context) => const ProfileScreen(),
      SearchScreen.routeName: (context) => const SearchScreen(),
      MessageScreen.routeName: (context) => const MessageScreen(),
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