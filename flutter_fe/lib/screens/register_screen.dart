import 'package:flutter/material.dart';
import 'package:flutter_fe/widgets/custom_button.dart';
import 'package:flutter_fe/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';


  final Function()? onTap;
  const RegisterScreen({super.key,required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  //text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

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
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                //space between
                const SizedBox(height: 25),
                //email textfield
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
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

                //confirm password textfield
                MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Confirm password',
                  obscureText: true //you cant see the characters
                ),

                //space between
                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  onTap: (){},
                  text: 'Sign Up'
                ),

                const SizedBox(height: 25),

                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey[700]
                      ),
                    ),
                    const SizedBox(width: 4),

                    GestureDetector(

                      onTap: widget.onTap,

                      child: const Text(
                        "Login now",
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