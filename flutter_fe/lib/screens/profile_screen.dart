import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:logger/logger.dart';

class ProfileScreen extends StatefulWidget{
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{
    final RequestUtil requestUtil = RequestUtil();
    late User user = User(userName: 'xy', firstName: 'xy', profilePictureUrl:'abc.com', lastName: 'xy', birthDate: '2002', gender: true);

    @override
  void initState() {
    super.initState();
    fetchUser();
  }

   Future<void> fetchUser() async {
    var response = await requestUtil.getUser(2);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      user =  User.fromJson(jsonData);
      Logger().i(user.profilePictureUrl);
      setState(() {}); // Frissítsd a UI-t a userrel
    } else {
      Logger().e('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: ListView(
       
        children:[
          const SizedBox(height: 30,),
          //profile pic
          Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(user.profilePictureUrl),
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            
          const SizedBox(height: 10,),
          //username
          Text(
            user.userName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:16
              ),
          ),


          //user bio
          const SizedBox(height: 20,),
          if (user.bios != null)
            Text(
              user.bios!,
              textAlign: TextAlign.center,
            ),



          //user posts
          Container(
            height: 400, // Set a fixed height or use other constraints
            child: ListView.builder(
              itemCount: user.posts?.length,
              itemBuilder: (context, index) {
                return CustomPostView(
                  post: user.posts![index],
                );
              },
            ),
          )
        ]
      )
    );
  }
}