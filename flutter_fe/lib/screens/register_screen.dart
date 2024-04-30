import 'package:flutter/material.dart';
import 'package:flutter_fe/screens/login_screen.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'package:flutter_fe/widgets/custom_button.dart';
import 'package:flutter_fe/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  final Function()? onTap;
  const RegisterScreen({super.key,required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final RequestUtil requestUtil = RequestUtil();

  //text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  final fistNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final profilePictureTextController = TextEditingController();
  final bioTextController = TextEditingController();
  final religionTextController = TextEditingController();
  final dateController = TextEditingController();

  bool genderValue = false;
  bool marriedValue = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      dateController.text = pickedDate.toIso8601String();
    }
  }

  Future<void> createUser() async {
    try {
      await requestUtil.postUserCreate(userNameTextController.text,
                                      fistNameTextController.text,
                                      lastNameTextController.text,
                                      emailTextController.text,
                                      passwordTextController.text,
                                      profilePictureTextController.text,
                                      dateController.text,
                                      genderValue,
                                      marriedValue,
                                      bioTextController.text,
                                      religionTextController.text);
      Logger().i(userNameTextController.text);

    } catch (error) {
      Logger().e('Error: $error');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
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

                  //username
                  MyTextField(
                    controller: userNameTextController,
                    hintText: 'Username',
                    obscureText: false
                  ),
                  const SizedBox(height: 10),


                  //firstname
                  MyTextField(
                    controller: fistNameTextController,
                    hintText: 'First Name',
                    obscureText: false
                  ),
                  const SizedBox(height: 10),


                  //last name
                  MyTextField(
                    controller: lastNameTextController,
                    hintText: 'Last Name',
                    obscureText: false
                  ),
                  const SizedBox(height: 10),

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

                  const SizedBox(height: 10,),

                  //profile picture
                  MyTextField(
                    controller: profilePictureTextController,
                    hintText: 'Profile picture url',
                    obscureText: false
                  ),
                  const SizedBox(height: 10),

                  //birth date
                  TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Birth date'),
                    onTap: () => _selectDate(context),
                  ),
                  
                  const SizedBox(height: 10,),

                  //religion
                  MyTextField(
                    controller: religionTextController,
                    hintText: 'Religion',
                    obscureText: false
                  ),

                  const SizedBox(height: 10,),

                  //bio
                  MyTextField(
                    controller: bioTextController,
                    hintText: 'Bio',
                    obscureText: false
                  ),
                  const SizedBox(height: 10),

                  //gender
                  DropdownButton<String>(
                    value: genderValue ? 'Female' : 'Male',
                    items: const [
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        genderValue = value == 'Female';
                      });
                    },
                  ),
                  
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: genderValue ? 'Married' : 'Single',
                    items: const [
                      DropdownMenuItem(
                        value: 'Married',
                        child: Text('Married'),
                      ),
                      DropdownMenuItem(
                        value: 'Single',
                        child: Text('Single'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        genderValue = value == 'Married';
                      });
                    },
                  ),

                  //space between
                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    onTap: (){
                      if(userNameTextController.text.isNotEmpty ||
                        fistNameTextController.text.isNotEmpty ||
                        lastNameTextController.text.isNotEmpty ||
                        emailTextController.text.isNotEmpty ||
                        passwordTextController.text.isNotEmpty ||
                        profilePictureTextController.text.isNotEmpty ||
                        dateController.text.isNotEmpty ||
                        bioTextController.text.isNotEmpty ||
                        religionTextController.text.isNotEmpty || 
                        confirmPasswordTextController.text.isNotEmpty){
                          if(passwordTextController.text != confirmPasswordTextController.text){
                            Fluttertoast.showToast(
                            msg: "Passwords are not matching",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          }else{
                          createUser();
                          setState(() {
                            widget.onTap;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen(onTap: () {})),
                          );
                          }
                      }else{
                        Fluttertoast.showToast(
                            msg: "All fields are required",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                      }
                    },
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
                  ),
                  const SizedBox(height: 20,)
                ],
              )
            )
          )
        )
      )
    );
  }
}