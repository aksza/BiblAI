import 'package:flutter/material.dart';
import 'package:flutter_fe/models/comment_model.dart';
import 'package:flutter_fe/models/post_model.dart';
import 'package:flutter_fe/models/user_model.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_comment.dart';
import 'package:flutter_fe/widgets/custom_post_view.dart';
import 'package:flutter_fe/widgets/custom_text_field.dart';
import 'package:logger/logger.dart';

class PostScreen extends StatefulWidget{
  static const routeName = '/post';
  final PostInfo post;
  final User user;
  final int userId;

  const PostScreen({super.key, required this.post,required this.user,required this.userId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
{
  final RequestUtil requestUtil = RequestUtil();
  final textController = TextEditingController();
  

  int getLastCommentId() {
    if (widget.post.comments != null && widget.post.comments!.isNotEmpty) {
      Comment lastComment = widget.post.comments!.last;
      int lastCommentId = lastComment.id;
      return lastCommentId;
    } else {
      return 0;
    }
  }

  void sendComment(){
    String commentText = textController.text.trim();
    int nextCommentId = getLastCommentId() + 1;

    if (commentText.isNotEmpty) {
      setState(() {
        widget.post.comments?.add(Comment(id: nextCommentId, content: commentText, userId: widget.userId, userName: widget.user.userName, profilePictureUrl: widget.user.profilePictureUrl, numLikes: 0, numDisLikes: 0, likedByUser: false, dislikedByUser: false));
        textController.clear();
      });
      createComment(commentText);
    }
  }
  Future<void> createComment(commentText) async {
    try {
      var date = DateTime.now();
    //TODO: atirni ezt a userid-t, hogy a usernek az id-ja legyen
      await requestUtil.postComment(commentText,widget.userId,widget.post.id,date.toIso8601String());

    } catch (error) {
      Logger().e('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: ListView(
       
        children:[
          //profile pic
          CustomPostView(post: widget.post, user: widget.user,userId: widget.userId),
          Container(
            padding: const EdgeInsets.only(left: 22.0, top: 8.0,bottom: 8.0),
            child: const Text(
              'Comments:',
            ),
          ),
          //comments
          Padding(
              padding: const EdgeInsets.only(top: 4.0,right: 20,left: 20,bottom: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Add a comment',
                      obscureText: false,
                      )
                  ),
                  IconButton(
                    onPressed: () {
                      sendComment();
                      setState(() {});
                    },
                    icon: const Icon(Icons.send_rounded),
                  )
                ],
              ),
            ),
          SizedBox(
            height: 220, 
            child: ListView.builder(
              // itemCount: widget.user.posts?.length,
              itemCount: widget.post.comments?.length,
              itemBuilder: (context, index) {
                return CustomCommentView(
                  comment: widget.post.comments![index],
                  user: widget.user,
                  userId: widget.userId,
                );
              },
            ),
          )
        ]
      )
    );
  }
  
}