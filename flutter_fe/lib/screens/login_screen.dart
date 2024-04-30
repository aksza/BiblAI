import 'package:flutter/material.dart';
import 'package:flutter_fe/screens/home_screen.dart';
import 'package:flutter_fe/widgets/custom_button.dart';
import 'package:flutter_fe/widgets/custom_text_field.dart';
import 'package:flutter_fe/auth/auth_service.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget{
  static const routeName = '/login';
  final Function()? onTap;

  LoginScreen({super.key, required this.onTap()});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  //text editing controllers
  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //logo
                Image.asset(
                  'assets/images/logo.png',
                  alignment: Alignment.center,
                  width: 100,
                  height: 100
                ),

                //space between
                const SizedBox(height: 50),

                //welcome back message
                Text(
                  "Welcome back to BiblAI",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                //space between
                const SizedBox(height: 25),
                //username textfield
                MyTextField(
                  controller: userNameTextController,
                  hintText: 'Username',
                  obscureText: false
                ),

                //space between
                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true //you cant see the characters
                ),

                //space between
                const SizedBox(height: 10),

                //sign in button
                Consumer<AuthService>(
                  builder: (context, auth,child) {
                    return MyButton(
                      onTap: () async {
                        if(userNameTextController.text.isEmpty || passwordTextController.text.isEmpty){
                          Logger().i("all fields are required");
                          Fluttertoast.showToast(
                            msg: "All fields are required",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                        bool loginSuccessful = await auth.login(userNameTextController.text, passwordTextController.text);

                        if (loginSuccessful) {
                          // Only navigate to HomeScreen if login is successful
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        } else {
                          Logger().i("Login failed");
                          Fluttertoast.showToast(
                            msg: "Incorrect username or password",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      text: 'Sign In'
                    );
                  }
                ),

                const SizedBox(height: 25),

                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey[700]
                      ),
                    ),
                    const SizedBox(width: 4),

                    GestureDetector(

                      onTap:widget.onTap,

                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        ),
                      ),
                    ),
                ],
                )
              ],
            )
          )
        )
      )
    );
  }
}