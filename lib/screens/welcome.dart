import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/models/video.dart';
import 'package:binge_prime/widgets/videoCard.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Video> videos;
  @override
  void initState() {
    firebase.getVideos().then((data) {
      setState(() {
        this.videos = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hi",
          style: Theme.of(context)
              .primaryTextTheme
              .subtitle2
              .copyWith(color: AppColors.textFieldBackgroundColor),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (videos == null)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (videos.length == 0)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "No Videos Found",
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return VideoCard(
                      video: videos[index],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
