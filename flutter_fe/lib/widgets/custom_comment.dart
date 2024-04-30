import 'package:flutter/material.dart';
import 'package:flutter_fe/models/comment_model.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:flutter_fe/widgets/dislike_button.dart';
import 'package:flutter_fe/widgets/like_button.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:logger/logger.dart';

//TODO:a dislike nem mukodik jol
class CustomCommentView extends StatefulWidget {  
  final Comment comment;
  final User user;
  final int userId;

  const CustomCommentView({
    Key? key,
    required this.comment,
    required this.user,
    required this.userId,
  }): super(key:key);


  @override
  State<CustomCommentView> createState() => _CustomCommentView();
}

class _CustomCommentView extends State<CustomCommentView>{

  bool isLiked = false;
  bool isDisliked = false;
  final RequestUtil requestUtil = RequestUtil();
  int numLikes = 0;
  int numDisLikes = 0;

  @override
  void initState(){
    super.initState();
    isLiked = widget.comment.likedByUser;
    isDisliked = widget.comment.dislikedByUser;
    numLikes = widget.comment.numLikes;
    numDisLikes = widget.comment.numDisLikes;
  }

  //toggle like
  void toggleLike(){
    setState(() {
      isLiked = !isLiked;
    });
    //access the doc in databse
    if(isDisliked && isLiked){
      updateCommentLike();
      setState(() {
        isDisliked = !isDisliked;
        numLikes++;
        numDisLikes--;
      }); 
    }
    else if(isLiked){
      likeComment();
      setState(() {
        numLikes++;
      });
    }
    else{
      unlikeComment();
      setState(() {
        numLikes--;
      });
    }
  }

  void toggleDislike(){
    setState(() {
      isDisliked = !isDisliked;
    });
    //access the doc in databse
    if(isDisliked && isLiked){
      updateCommentLike();
      setState(() {
        isLiked = !isLiked;
        numLikes--;
        numDisLikes++;
      }); 
    }
    else if(isDisliked){
      dislikeComment();
      setState(() {
        numDisLikes++;
      });
    }
    else{
      unlikeComment();
      setState(() {
        numDisLikes--;
      });
    }
  }

  Future<void> likeComment() async {
    try {
      await requestUtil.postCommentLike(isLiked,widget.userId,widget.comment.id);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  Future<void> unlikeComment() async {
    try {
      await requestUtil.deleteCommentUnlike(widget.userId,widget.comment.id);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  Future<void> dislikeComment() async {
    try {
      await requestUtil.postCommentLike(!isDisliked,widget.userId,widget.comment.id);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  Future<void> updateCommentLike() async{
    try{
      await requestUtil.putCommentUpdateLike(widget.userId,widget.comment.id);
    } catch(error){
      Logger().e('Error: $error');
    }
  }

  void deleteComment(){
    fdeleteComment();
    setState(() {
      
    });
  }

  Future<void> fdeleteComment() async{
    try{
      await requestUtil.deleteCommentById(widget.comment.id);
    } catch(error){
      Logger().e('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                        MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.comment.userId)),
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
                      image: NetworkImage(widget.comment.profilePictureUrl),
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
                              MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.comment.userId)),
                            );      
                    },
                    child:
                      Text(
                        widget.comment.userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.comment.content),
                ],
              ),
            ),

            if(widget.userId == widget.comment.userId)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Törlés előtt megerősítő párbeszédpanel megjelenítése
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Törlés megerősítése"),
                      content: Text("Biztosan törölni szeretnéd a kommentet?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Nem gombra kattintva bezárás
                            Navigator.of(context).pop();
                          },
                          child: Text("Nem"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Igen gombra kattintva a törlési funkció hívása és bezárás
                            deleteComment();
                            Navigator.of(context).pop();
                          },
                          child: Text("Igen"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 30,),
            //like button
            LikeButton(
              isLiked: isLiked,
              onTap: toggleLike
            ),
            Text(
              //int.parse(i.toString)
              numLikes.toString(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 20),
            //dislike button
            DislikeButton(
              isDisliked: isDisliked,
              onTap: toggleDislike
            ),
            Text(
              numDisLikes.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ],
    ),
  );
  }
}