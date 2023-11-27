import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';

class CustomPostView extends StatefulWidget {  
  final Post post;

  const CustomPostView({
    Key? key,
    required this.post,
  }): super(key:key);


  @override
  State<CustomPostView> createState() => _CustomPostView();
}

class _CustomPostView extends State<CustomPostView>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),

      margin: EdgeInsets.only(top: 25, left: 25,right: 25),
      padding: EdgeInsets.all(25),
      child: Row(children: [
        //profile pic
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[400]
          ),
          padding: EdgeInsets.all(10),
          child: Icon(Icons.person, color: Colors.white,),
        ),

        //space
        const SizedBox(width: 20,),

        //posztok (username es poszt)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("aksza", 
            style: TextStyle(
              color: Colors.grey[200]
              ),
            ),
            const SizedBox(height: 10,),
            Text("poszt"),
        ],)
      ]),
    );
  }
}