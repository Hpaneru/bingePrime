import 'package:binge_prime/screens/home.dart';
import 'package:binge_prime/screens/login.dart';
import 'package:binge_prime/screens/signup.dart';
import 'package:binge_prime/screens/splash.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        "/signupScreen": (context) => SignupScreen(),
        "/loginScreen": (context) => LoginScreen(),
        "/homeScreen": (context) => HomeScreen(),
      },
    );
  }
}
