import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';

class CustomPostView extends StatefulWidget {  
  final PostInfo post;

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
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.post.profilePictureUrl),
                  ),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.userName,
                    style: TextStyle(
                      color: Colors.grey[500],
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
        const SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 30,),
            const Icon(Icons.arrow_upward_rounded),
            Text(
              widget.post.numLikes.toString(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 20),
            const Icon(Icons.arrow_downward_rounded),
            Text(
              widget.post.numDisLikes.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 20),
            const Icon(Icons.comment),
            Text(
              widget.post.commentsNum.toString(),
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ],
    ),
  );
  }
}