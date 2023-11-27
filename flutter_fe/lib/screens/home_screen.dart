import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_button.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_fe/utils/request_util.dart';
// import 'dart:developer' as developer;

RequestUtil util = RequestUtil();


class HomeScreen extends StatelessWidget{
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){

    // var logger = Logger();
    List<Post> posts = Post.postss;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
        
body: Container(
          alignment: Alignment.center,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Message',
              style: TextStyle(fontSize: 24),
            ),
            // developer.log outside the Text widget
          // ElevatedButton(
//             onPressed: () async{
//               http.Response response = await util.getHome();
//               logger.d('Response: ${response.body}');
//               },
//               child: const Text('api')
//            ),
          ],
        ),
        ),
    );
  }
}
