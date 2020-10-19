import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/screens/home.dart';
import 'package:binge_prime/screens/intro.dart';
import 'package:binge_prime/screens/login.dart';
import 'package:binge_prime/screens/signup.dart';
import 'package:binge_prime/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColors.backgroundColor,
        disabledColor: AppColors.disabledColor,
      ),
      home: SplashScreen(),
      routes: {
        "/introScreen": (context) => IntroScreen(),
        "/signupScreen": (context) => SignupScreen(),
        "/loginScreen": (context) => LoginScreen(),
        "/homeScreen": (context) => HomeScreen(),
      },
    );
  }
}
