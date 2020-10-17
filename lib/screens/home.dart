import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/screens/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hey Welcome! You are in Home Screen"),
              SizedBox(height: 20),
              RaisedButton(
                  child: Text("LOGOUT"),
                  onPressed: () {
                    firebase.logout().then((data) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
