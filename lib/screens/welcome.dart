import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/models/video.dart';
import 'package:binge_prime/screens/videolist.dart';
import 'package:binge_prime/widgets/custom_button.dart';
import 'package:binge_prime/widgets/videoCard.dart';
import 'package:binge_prime/widgets/video_player.dart';
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

  playSong() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => VideoPlayerWidget(
                'https://firebasestorage.googleapis.com/v0/b/bingeprime-c4237.appspot.com/o/videos%2F1605095445909-76be182?alt=media&token=16657494-1c21-47cd-83ca-0a97e50fef9b')));
  }
// https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4
  // https://firebasestorage.googleapis.com/v0/b/bingeprime-c4237.appspot.com/o/videos%2F1605095445909-76be182?alt=media&token=16657494-1c21-47cd-83ca-0a97e50fef9b

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (videos == null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (videos.length == 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "No Videos Found",
                    ),
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: videos.map((video) {
                          return VideoCard(video);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
