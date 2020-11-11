import 'package:flutter/material.dart';

class CommingSoonScreen extends StatefulWidget {
  @override
  _CommingSoonScreenState createState() => _CommingSoonScreenState();
}

class _CommingSoonScreenState extends State<CommingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hey Welcome! You are in Comming Soon Screen"),
            ],
          ),
        ),
      ),
    );
  }
}
