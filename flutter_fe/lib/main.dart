import 'package:flutter/material.dart';
import 'package:flutter_fe/screens/home_screen.dart';
import 'package:flutter_fe/screens/message_screen.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/screens/search_screen.dart';
import 'package:flutter_fe/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
    Map<String, WidgetBuilder> _getRoutes() {
    return {
      '/': (context) => SplashScreenPage(),
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

