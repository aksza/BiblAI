import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_bottom_app_bar.dart';

class SearchScreen extends StatelessWidget{
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'Search',
          style: TextStyle(fontSize:24),
        ),
      ),
    );
  }
}