import 'package:flutter/material.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/screens/message_screen.dart';
import 'package:flutter_fe/screens/profile_screen.dart';



class CustomAnswerView extends StatefulWidget {  
  final AnswerView post;
  final User user;
  final int userId;

  const CustomAnswerView({
    Key? key,
    required this.post,
    required this.user,
    required this.userId,
  }): super(key:key);


  @override
  State<CustomAnswerView> createState() => _CustomAnswerView();
}

class _CustomAnswerView extends State<CustomAnswerView>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: (){
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.userId)),
                      );      
            },
            child:
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(widget.user.profilePictureUrl),
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              )
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                    Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.userId)),
                            );      
                    },
                    child:
                      Text(
                        widget.user.userName,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.post.question),
                  const SizedBox(height: 10),
                  Text(widget.post.answer),
                ],
              ),
            ),
          ],
        ),
        
      ],
    ),
  );
  }
}