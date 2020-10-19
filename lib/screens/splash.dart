import 'dart:async';
import 'package:binge_prime/helpers/colors.dart';
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
            context, "/introScreen", (predicate) => false);
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.gradientColors,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // TODO : ADD ICON HERE
                  // Image.asset(
                  //   "assets/logo.png",
                  //   fit: BoxFit.fitWidth,
                  //   scale: 0.8,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xff1FE5D1),
                          valueColor:
                              new AlwaysStoppedAnimation(Color(0xff0B1A3D)),
                          strokeWidth: 1.8,
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Binge Prime",
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle2
                    .copyWith(fontSize: 24, color: AppColors.backgroundColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
