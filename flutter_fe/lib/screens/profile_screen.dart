import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';

class ProfileScreen extends StatelessWidget{
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'Profile',
          style: TextStyle(fontSize:24),
        ),
      ),
    );
  }
}