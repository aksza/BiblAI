import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_button.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_fe/utils/request_util.dart';
// import 'dart:developer' as developer;

RequestUtil requestUtil = RequestUtil();


class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RequestUtil requestUtil = RequestUtil();
  late List<PostInfo> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    var response = await requestUtil.getPost(1);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      posts = (jsonData as List).map((data) => PostInfo.fromJson(data)).toList();
      setState(() {}); // Frissítsd a UI-t a bejegyzésekkel
    } else {
      Logger().e('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Center(
        child: posts != null
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return CustomPostView(
                          post: posts[index],
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
