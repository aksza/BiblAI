import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_fe/widgets/custom_chat_bubble.dart';
import 'package:flutter_fe/widgets/custom_text_field.dart';

class ChatMessage {
  final String text;
  final bool isCurrentUser;

  ChatMessage({
    required this.text,
    required this.isCurrentUser,
  });
}


class MessageScreen extends StatefulWidget{
  static const routeName = '/message';
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  //text controller
  final textController = TextEditingController();
  List<ChatMessage> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Center(
        child: Column(
          children: [
            //suggested messages
            Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    text: chatMessages[index].text,
                    isCurrentUser: chatMessages[index].isCurrentUser,
                  );
                },
              ),
            ),

            //mytextfield, send button
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
                  //TODO: megirni a sendMessaget
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
        chatMessages.add(ChatMessage(
          text: messageText,
          isCurrentUser: true,
        ));
        textController.clear();
      });
    }
  }
}



// class MessageScreen extends StatelessWidget{
//   static const routeName = '/message';

//   const MessageScreen({super.key});

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       bottomNavigationBar: const CustomBottomAppBar(),
//       body: Container(
//         alignment: Alignment.center,
//         child: const Text(
//           'Message',
//           style: TextStyle(fontSize:24),
//         ),
//       ),
//     );
//   }
// }