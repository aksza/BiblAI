import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';

class HomeScreen extends StatelessWidget{
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'Home',
          style: TextStyle(fontSize:24),
        ),
      ),
    );
  }
}

