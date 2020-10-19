import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/screens/login.dart';
import 'package:binge_prime/widgets/button.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.gradientColors,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 200),
                Text(
                  "Let's Get",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline6
                      .copyWith(fontSize: 50, color: AppColors.backgroundColor),
                ),
                Text(
                  "Started",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline6
                      .copyWith(fontSize: 50, color: AppColors.backgroundColor),
                ),
                SizedBox(height: 20),
                Text(
                  "Enjoy The best audio",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2
                      .copyWith(fontSize: 16, color: AppColors.backgroundColor),
                ),
                Text(
                  "and video stations",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2
                      .copyWith(fontSize: 16, color: AppColors.backgroundColor),
                ),
                Text(
                  "from anywhere, don't",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2
                      .copyWith(fontSize: 16, color: AppColors.backgroundColor),
                ),
                Text(
                  "miss anything",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2
                      .copyWith(fontSize: 16, color: AppColors.backgroundColor),
                ),
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 32),
                  child: CustomButton(
                    onPress: () => Navigator.pushNamed(context, "/loginScreen"),
                    label: "GET STARTED",
                    color: AppColors.customButtonColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
