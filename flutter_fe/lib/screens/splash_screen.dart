// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_fe/auth/login_or_register.dart';
import 'package:flutter_fe/utils/request_util.dart';
import 'home_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

// import 'package:flutter_fe/models/splash_model.dart';


class SplashScreenPage extends StatelessWidget {
  static const routeName = '/';

  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1, end: 0),
          duration: const Duration(seconds: 2),
          builder: (BuildContext context, double value, Widget? child) {
            return Transform.translate(
              offset: Offset(0.0, value * MediaQuery.of(context).size.height),
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/logo.png',
            // width: 250,
            // height: 250,
          ),
        ),
      ),
      nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
      // pageTransitionType: PageTransitionType.scale,
    );
  }
}