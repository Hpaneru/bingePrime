import 'dart:async';
import 'package:binge_prime/helpers/firebase.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription userStateListener;

  @override
  void dispose() {
    super.dispose();
    userStateListener.cancel();
  }

  @override
  void initState() {
    super.initState();
    savedUser();
  }

  savedUser() async {
    userStateListener = firebase.getUserStateListener().listen((data) async {
      handelResult(data);
    });
  }

  handelResult(user) async {
    if (user == null) {
      try {
        Navigator.pushNamedAndRemoveUntil(
            context, "/loginScreen", (predicate) => false);
      } catch (e) {
        print(e.message);
      }
    } else {
      try {
        Navigator.pushNamedAndRemoveUntil(
            context, "/homeScreen", (predicate) => false);
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
