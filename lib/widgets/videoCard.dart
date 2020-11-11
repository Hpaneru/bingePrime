import 'package:binge_prime/models/video.dart';
import 'package:binge_prime/widgets/video_player.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatefulWidget {
  final Video video;
  VideoCard(this.video);
  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerWidget(widget.video.link),
          ),
        );
      },
      child: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.video.title),
          ),
        ),
      ),
    );
  }
}
