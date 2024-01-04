import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:http/src/response.dart';
import 'package:logger/logger.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fe/auth/db_service.dart';


RequestUtil requestUtil = RequestUtil();

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RequestUtil requestUtil = RequestUtil();
  //TODO:ezeket majd at kell rakni a statefullba, mert lesz login, es akkor required kell lennie
  late List<PostInfo> posts = [];
  late User user = User(userName: "xy", firstName: "xy", lastName: "xy", birthDate: "02.18", gender: true, profilePictureUrl: "xyz.com");
  var userId;
  // AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    Provider.of<AuthService>(context, listen: false).addListener(_onAuthServiceChange);
    fetchData();
  }
  
  @override
  void dispose() {
    // Leiratkozunk az AuthService-ről a widget megszűnésekor
    Provider.of<AuthService>(context, listen: false).removeListener(_onAuthServiceChange);
    super.dispose();
  }

  void _onAuthServiceChange() {
    // Itt kezelheted az AuthService állapotváltozását
    // Például, ha be vagy jelentkezve, hívhatod a fetchPosts metódust
    if (Provider.of<AuthService>(context, listen: false).isAuthenticated) {
      fetchPosts();
    }
  }

  //TODO:ezeket is atirni try catchre
  Future<void> fetchPosts() async {
    Response response;
    // Logger().i(Provider.of<AuthService>(context, listen: false).isAuthenticated);
    if(Provider.of<AuthService>(context, listen: false).isAuthenticated)
    {
      response = await requestUtil.getPostPrivate();
      Logger().i("privat");
    }else{
      response = await requestUtil.getPostPublic();
      Logger().i("public");
    }

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      
      if(jsonData.containsKey("userId")){
        userId = jsonData["userId"];
        setState(() {   
        });
        await DatabaseProvider().saveUserId(userId);
      }


      if (jsonData.containsKey("posts")) {
        var postsData = jsonData["posts"];
        posts = (postsData as List).map((data) => PostInfo.fromJson(data)).toList();
        setState(() {
        });        
      } else {
        Logger().e('Error: Missing "posts" property in JSON data');
      }
    } else {
      Logger().e('Error: ${response.reasonPhrase}');
    }
  }

  Future<void> fetchUser() async {
    var response = await requestUtil.getUser(userId);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      user =  User.fromJson(jsonData);
      setState(() {}); // Frissítsd a UI-t a userrel
    } else {
      Logger().e('Error: ${response.reasonPhrase}');
    }
  }

  Future<void> fetchData() async {
    await fetchPosts();
    await fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      //sign out
      // actions:[
      //   IconButton(onPressed: (){DataBaseProvider().logOut(context);}, icon: Icon(Icons.exit_to_app))
      // ]
      body: Center(
        child: posts != null
            ? Column(
                children: [
                  SizedBox(height: 30,),
                  Text("BIBLAI",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return CustomPostView(
                          post: posts[index],
                          user: user,
                          userId: userId,
                        );
                      },
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
