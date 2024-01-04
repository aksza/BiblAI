import 'package:flutter/material.dart';
import 'package:flutter_fe/auth/db_service.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/screens/search_screen.dart';
import 'package:flutter_fe/screens/home_screen.dart';
import 'package:flutter_fe/screens/message_screen.dart';
import 'package:provider/provider.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {

  int userId = 0;

  void initState() {
    super.initState();
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    int response = await DatabaseProvider().getUserId();

    userId = response;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // var userId = Provider.of<DatabaseProvider>(context).userId;


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
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(userId: userId),
                  ),
                );

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


