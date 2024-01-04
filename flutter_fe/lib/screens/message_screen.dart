import 'package:flutter/material.dart';
import 'package:flutter_fe/auth/db_service.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/models/verse_model.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/widgets/custom_answer.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_comentfield.dart';
import 'package:flutter_fe/widgets/custom_post_button.dart';
import 'package:flutter_fe/widgets/custom_recommendation.dart';
import 'package:flutter_fe/widgets/custom_text_field.dart';
import 'package:flutter_fe/widgets/custom_verse.dart';
import 'package:logger/logger.dart';
import 'dart:convert';

class AnswerView {
  final String question;
  final String answer;
  final String content;
  final bool anonym;

  AnswerView({
    required this.question,
    required this.answer,
    required this.content,
    required this.anonym,
  });
}

class MessageScreen extends StatefulWidget{
  static const routeName = '/message';
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final RequestUtil requestUtil = RequestUtil();
  late int userId = 0;
  late User user = User(userName: "xy", firstName: "xy", lastName: "xy", birthDate: "02.18", gender: true, profilePictureUrl: "xyz.com");
  late List<Verse> verses = [];

  @override
  void initState() {
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

  //text controller
  final textController = TextEditingController();
  final commentController = TextEditingController();
  List<AnswerView> answer = [];
  bool canSendMessage = true;
  bool isAnonym = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Center(
        child: Column(
          children: [
            //suggested messages
            
            if(!canSendMessage)
            const SizedBox(height:100),
            if(!canSendMessage)
            CustomAnswerView(post: answer[0], user: user, userId: userId),   
            if(!canSendMessage)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                Expanded(
                  child:MyCommentField(
                  controller: commentController, 
                  hintText: "Add a comment", 
                  obscureText: false),
                ),                                    
            ),
            if(!canSendMessage)
            Row(
              children:[
                const SizedBox(width: 95,),
                const Text(
                  "Anonym posting",
                  style: 
                  TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 10,),
                Transform.scale(
                  scale: 0.7,
                  child: Switch.adaptive(
                    value: isAnonym,
                    onChanged: (bool value) {
                      setState(() {
                        isAnonym = value;
                      });
                    
                    },
                    activeColor: Colors.black,
                  ),
                )
              ]
            ),

            if(!canSendMessage)
            Row(
              children: [
                const SizedBox(width: 50),
                const Text("Verses: "),
                if (verses.isNotEmpty)
                  ...verses.map((verse) => CustomVerse(verse: verse)).toList(),
              ],
            ),
            if(!canSendMessage)
            const SizedBox(height: 10,),

            if(!canSendMessage)
            Row(
              children: [
                const SizedBox(width: 55),
                MyPostButton(icon: const Icon(Icons.send),onTap: createNewPost, text: "Share the answer"),
                const SizedBox(width:10),
                MyPostButton(icon: const Icon(Icons.refresh),onTap: askNewQuestion, text: "Ask a new question"),
              ],
            ),
            
            if(canSendMessage)
            Expanded(
              child: 
              Column(children: [
                const SizedBox(height:60),
                const Text("Ask something from BiblAI!",
                  style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  ),
                Expanded(
                  child:
                  Align(alignment: Alignment.bottomCenter,
                    child:
                      Column(children: [
                        const SizedBox(height: 220,),
                        Row(
                          children:[
                            const SizedBox(width: 20,),
                            CustomRecommendButton(
                              onTap: () {
                                textController.text = "Who is Jesus?";
                              },
                              text: "Who is Jesus?",
                            ),  
                            const SizedBox(width: 10,),
                            CustomRecommendButton(
                              onTap: (){textController.text = "What is the meaning of life?";},
                              text: "What is the meaning of life?"),
                          ]
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children:[
                            const SizedBox(width: 20,),
                            CustomRecommendButton(
                              onTap: (){textController.text = "What is the third commandment?";},
                              text: "What is the third commandment?"),
                            const SizedBox(width: 10,),
                            CustomRecommendButton(
                              onTap: (){textController.text = "Is there life after death?";},
                              text: "Is there life after death?"),
                          ]
                        )
                      ]
                    )
                  )
                )
              ],)
            ),
            //mytextfield, send button
            if(canSendMessage == true)
            
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: textController,
                          hintText: 'Ask something from the Bible...',
                          obscureText: false,
                          )
                      ),
                      
                      //send button
                      IconButton(onPressed: sendMessage, icon: const Icon(Icons.send_rounded))
                    ],
                  ),
                )
                    
          ]
        ),
      ),
    );
  }

  void sendMessage() {
    String messageText = textController.text.trim();

    if (messageText.isNotEmpty) {
      setState(() {
        verses.add(Verse(book: "Psalm", chapter: "56", verse: "2",link: "https://www.bible.com/bible/1/.12.3.kjv"));
        verses.add(Verse(book: "Psalm", chapter: "1", verse: "10", link: "https://www.bible.com/bible/1/.12.3.kjv"));
        answer.add(AnswerView(question: textController.text,answer: "Good question",content: "okay", anonym: isAnonym));
        canSendMessage = false;
      });
    }
  }

  void askNewQuestion(){
    setState(() {
      if(answer.isNotEmpty){
        answer.removeLast();
      }
      while(verses.isNotEmpty){
        verses.removeLast();
      }
      textController.clear();
      commentController.clear();
      canSendMessage = true;

    });
  }

  Future<void> createPost() async {
    try {
      var date = DateTime.now();
      await requestUtil.postCreatePost(textController.text, "Good question", commentController.text, isAnonym, userId, date.toIso8601String(),verses);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  void createNewPost(){
    createPost();

    setState(() {
      if(answer.isNotEmpty){
        answer.removeLast();
      }
      textController.clear();
      commentController.clear();
      canSendMessage = true;
    });
    
  }
}
