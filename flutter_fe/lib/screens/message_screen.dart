import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';


class MessageScreen extends StatelessWidget{
  static const routeName = '/message';

  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'Message',
          style: TextStyle(fontSize:24),
        ),
      ),
    );
  }
}