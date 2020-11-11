import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/models/video.dart';
import 'package:binge_prime/widgets/videoCard.dart';
import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
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
        title: Text("All Videoes"),
      ),
      body: Container(
        child: Column(
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
    );
  }
}
