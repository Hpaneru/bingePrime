import 'dart:async';
import 'package:binge_prime/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoFile;
  VideoPlayerWidget(this.videoFile);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;
  AnimationController _animationController;
  bool buffering = true;
  Timer t;
  Duration currentTime, totalTime;
  double loadingValue;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _controller = VideoPlayerController.network(widget.videoFile)
      ..initialize().then((_) {
        buffering = false;
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          loadingValue = 0;
          currentTime = _controller.value.position;
          totalTime = _controller.value.duration;
          _controller.play();
          _animationController.forward();
          startTimer();
        });
      });
  }

  startTimer() {
    t = Timer.periodic(Duration(milliseconds: 100), (timer) async {
      setState(() {
        currentTime = _controller.value.position;
        loadingValue = currentTime.inMilliseconds / totalTime.inMilliseconds;
        if (currentTime.inMilliseconds == totalTime.inMilliseconds)
          _animationController.reverse();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    t.cancel();
  }

  setPlaying(bool isPlaying) async {
    if (!_controller.value.initialized) return;
    if (totalTime.inMilliseconds == currentTime.inMilliseconds) {
      await _controller.seekTo(Duration());
      _controller.play();
      _animationController.forward();
    } else if (isPlaying)
      _controller.pause();
    else
      _controller.play();
    if (isPlaying)
      _animationController.reverse();
    else
      _animationController.forward();
  }

  String get duration {
    String value = "";
    if (currentTime == null)
      value += "-:-";
    else
      value += getFormattedTime(currentTime.inSeconds);

    value += " / ";
    if (totalTime == null)
      value += "-:-";
    else
      value += getFormattedTime(totalTime.inSeconds);
    return value;
  }

  getFormattedTime(int seconds) {
    var d = Duration(seconds: seconds);
    String title = "";
    if (d.inHours > 0) title += "${(d.inHours % 24)}h ";
    if (d.inMinutes > 0) title += "${(d.inMinutes % 60)}m ";
    title += "${(d.inSeconds % 60)}s";
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _animationController,
                    size: 30,
                  ),
                  onPressed: () {
                    setPlaying(_controller.value.isPlaying);
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      LinearProgressIndicator(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        value: loadingValue,
                      ),
                      SizedBox(height: 5),
                      Text(duration),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    Mdi.close,
                    color: AppColors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
