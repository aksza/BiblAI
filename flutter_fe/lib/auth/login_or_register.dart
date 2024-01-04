import 'package:flutter/material.dart';
import 'package:flutter_fe/screens/login_screen.dart';
import 'package:flutter_fe/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {

  LoginOrRegister({super.key});


  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show the login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginScreen(onTap: togglePages);
    }else{
      return RegisterScreen(onTap: togglePages);
    }
  }
}