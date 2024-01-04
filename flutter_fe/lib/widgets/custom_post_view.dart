import 'package:flutter/material.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/models/verse_model.dart';
import 'package:flutter_fe/screens/post_screen.dart';
import 'package:flutter_fe/screens/profile_screen.dart';
import 'package:flutter_fe/widgets/custom_verse_button.dart';
import 'package:flutter_fe/widgets/dislike_button.dart';
import 'package:flutter_fe/widgets/like_button.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:logger/logger.dart';

//TODO:a dislike nem mukodik jol
class CustomPostView extends StatefulWidget {  
  final PostInfo post;
  final User user;
  final int userId;

  const CustomPostView({
    Key? key,
    required this.post,
    required this.user,
    required this.userId,
  }): super(key:key);


  @override
  State<CustomPostView> createState() => _CustomPostView();
}

class _CustomPostView extends State<CustomPostView>{

  bool isLiked = false;
  bool isDisliked = false;
  final RequestUtil requestUtil = RequestUtil();
  int numLikes = 0;
  int numDisLikes = 0;
  bool isAnonym = false;
  List<Verse> verses = [];

  @override
  void initState(){
    super.initState();
    isLiked = widget.post.likedByUser;
    isDisliked = widget.post.dislikedByUser;
    numLikes = widget.post.numLikes;
    numDisLikes = widget.post.numDisLikes;
    isAnonym = widget.post.anonym;
    verses = widget.post.verses;
  }

  //toggle like
  void toggleLike(){
    setState(() {
      isLiked = !isLiked;
    });
    //access the doc in databse
    if(isDisliked && isLiked){
      updatePostLike();
      setState(() {
        isDisliked = !isDisliked;
        numLikes++;
        numDisLikes--;
      }); 
    }
    else if(isLiked){
      likePost();
      setState(() {
        numLikes++;
      });
    }
    else{
      unlikePost();
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
      updatePostLike();
      setState(() {
        isLiked = !isLiked;
        numLikes--;
        numDisLikes++;
      }); 
    }
    else if(isDisliked){
      dislikePost();
      setState(() {
        numDisLikes++;
      });
    }
    else{
      unlikePost();
      setState(() {
        numDisLikes--;
      });
    }

  }

  Future<void> likePost() async {
    try {
      await requestUtil.postLikePost(isLiked,widget.userId,widget.post.id);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  Future<void> unlikePost() async {
    try {
      await requestUtil.deletePostUnlike(widget.userId,widget.post.id);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  Future<void> dislikePost() async {
    try {
      await requestUtil.postLikePost(!isDisliked,widget.userId,widget.post.id);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }

  Future<void> updatePostLike() async{
    try{
      await requestUtil.putPostUpdateLike(widget.userId,widget.post.id);
    } catch(error){
      Logger().e('Error: $error');
    }
  }

  void refreshPostView() {
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector( 
      onTap: (){
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostScreen(post: widget.post,user: widget.user,userId: widget.userId,)),
                );      
      },
      child: Container(
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
                        MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.post.userId)),
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
                      image: isAnonym
                            ? const NetworkImage("https://i1.sndcdn.com/avatars-000179405104-pcjko5-t240x240.jpg") // Ide tedd be az anonym ikon elérési útvonalát
                            : NetworkImage(widget.post.profilePictureUrl),
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
                              MaterialPageRoute(builder: (context) => ProfileScreen(userId: widget.post.userId)),
                            );      
                    },
                    child:
                      Text(
                         isAnonym ? "Anonym" : widget.post.userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.post.question),
                  const SizedBox(height: 10),
                  const Text("Answer:",
                    style: TextStyle(
                    color: Colors.grey),),
                  const SizedBox(height: 5,),
                  Text(widget.post.answer),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Row(
              children: [
                const SizedBox(width: 60),
                const Text("Verses: ",
                  style: TextStyle(
                  color: Colors.grey),
                  ),
                if (verses.isNotEmpty)
                  ...verses.map((verse) => CustomVerseButton(verse: verse)).toList(),
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
  )
    );
  }
}