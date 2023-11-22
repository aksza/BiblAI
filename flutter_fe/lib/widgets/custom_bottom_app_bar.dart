import 'package:flutter/material.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/screens/search_screen.dart';
import 'package:flutter_fe/screens/home_screen.dart';
import 'package:flutter_fe/screens/message_screen.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child:SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          IconButton(
            onPressed: (){
              Navigator.popAndPushNamed(context,HomeScreen.routeName);

            },
            color:Colors.black,
            iconSize: 30,
            icon: const Icon(Icons.home)
            ),

          IconButton(
          onPressed: (){
            Navigator.popAndPushNamed(context,SearchScreen.routeName);
          },
          color:Colors.black,
          iconSize: 30,
          icon: const Icon(Icons.search)
          ),

          IconButton(
          onPressed: (){
            Navigator.popAndPushNamed(context,MessageScreen.routeName);
          },
          color:Colors.black,
          iconSize: 30,
          icon: const Icon(Icons.message)
          ),

          IconButton(
            onPressed: (){
              Navigator.pushNamed(context,ProfileScreen.routeName);

            },
            color:Colors.black,
            iconSize: 30,
            icon: const Icon(Icons.person)
            )
        ],)
      )
      );
  }
}


