import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:logger/logger.dart';

class ProfileScreen extends StatefulWidget{
  static const routeName = '/profile';
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{
    final RequestUtil requestUtil = RequestUtil();
    late User user = User(userName: 'test', firstName: 'test', profilePictureUrl:'https://th.bing.com/th/id/OIP.pbojkN8pg6P0d59BynGVrgHaGt?rs=1&pid=ImgDetMain', lastName: 'test', birthDate: '2002', gender: true);

    @override
  void initState() {
    super.initState();
    fetchUser();
  }

   Future<void> fetchUser() async {
    var response = await requestUtil.getUser(widget.userId);
    Logger().i(widget.userId);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      user =  User.fromJson(jsonData);
      Logger().i(user.profilePictureUrl);
      setState(() {}); // update
    } else {
      Logger().e('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: 
      ListView(
       
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
            style: const TextStyle(
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
          SizedBox(
            height: 320,
            child: user.posts != null ? 
              ListView.builder(
              itemCount: user.posts?.length,
              itemBuilder: (context, index) {
                return CustomPostView(
                  post: user.posts![index],
                  user: user,
                  userId: 2,
                );
              },
            ):
            Text(" "),

          )
        ]
      )

    );
  }
}