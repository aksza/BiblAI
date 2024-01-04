import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fe/auth/db_service.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class SearchScreen extends StatefulWidget{
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen>{

  final textController = TextEditingController();
  late List<PostInfo> posts = [];
  final RequestUtil requestUtil = RequestUtil();
  late int userId = 0;
  late User user = User(userName: "xy", firstName: "xy", lastName: "xy", birthDate: "02.18", gender: true, profilePictureUrl: "xyz.com");

  @override 
  void initState(){
    super.initState();
    fetchData();
  }
  Future<void> fetchUserId() async {
    int response = await DatabaseProvider().getUserId();
    userId = response;
    setState(() {
    });
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
    await fetchUserId();
    await fetchUser();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                Row(
                  children: [
                    Expanded(
                      child: SearchBar(
                        elevation: MaterialStateProperty.all(25.0),
                        // leading: const Icon(Icons.search),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 240, 240, 240),
                        ),
                        controller: textController,
                        hintText: "Are you searching for something?",
                        hintStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey)),                    
                      ),
                    ),
                    IconButton(onPressed: search,icon: const Icon(Icons.search_rounded)),
                  ]
                )
            ),
             Expanded(
            child: posts.isNotEmpty
                ? ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return CustomPostView(
                        post: posts[index],
                        user: user,
                        userId: userId,
                      );
                    },
                  )
                : const Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(     
                      children: [
                        SizedBox(height: 10,),
                        Text(
                            "Did you know?                                       ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5
                            ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "The Bible is the most translated and distributed book in the world. Exploring its rich tapestry of stories, teachings, and historical accounts can provide not only spiritual insights but also a fascinating cultural and literary journey.",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.2
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("May your journey through the Bible bring you wisdom, inspiration, and a deeper understanding of the world around you. Happy exploring!",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1.2
                          ),
                        ),
                        SizedBox(height: 20,),
                        Image(
                          image: NetworkImage("https://media0.giphy.com/media/oRby1FQYqVqtHQ6UTG/giphy.gif?cid=6c09b9527hl1zqqj1vqb2wpz8ccvysg79qt5s22bdl7gdfqv&ep=v1_stickers_related&rid=giphy.gif&ct=s"),
                          width: 120,
                          height: 120,
                          )
                      ],
                    ),
                )
          ),
          ]
        ) ,
        )
    );
  }

Future<void> fetchSearch() async {
    Response response;
    response = await requestUtil.getPostSearch(textController.text);
    
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      Logger().i(jsonData);
      posts = (jsonData as List).map((data) => PostInfo.fromJson(data)).toList();
      setState(() {
      });        
      
    } else {
      Logger().e('Error: ${response.reasonPhrase}');
    }
  }

  void search(){
    if(textController.text.isNotEmpty){
      fetchSearch();
      setState(() {
        textController.clear();
      });
    }
  }
}

// class SearchScreen extends StatelessWidget{
//   static const routeName = '/search';

//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       bottomNavigationBar: const CustomBottomAppBar(),
//       body: Container(
//         alignment: Alignment.center,
//         child: const Text(
//           'Search',
//           style: TextStyle(fontSize:24),
//         ),
//       ),
//     );
//   }
// }