import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/models/video.dart';
import 'package:binge_prime/widgets/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class VideoCard extends StatefulWidget {
  final Video video;
  VideoCard({this.video});
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
        margin: EdgeInsets.all(8),
        height: 150,
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1),
                width: 90.0,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: widget.video.iconUrl == null
                      ? Container(
                          color: Theme.of(context).primaryColor.withAlpha(40),
                          child: Icon(Mdi.play,
                              color: AppColors.settingTextColor.withAlpha(100),
                              size: 80),
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.cover, imageUrl: widget.video.iconUrl),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.video.title ?? "",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle2
                            .copyWith(
                                color: AppColors.textFieldBackgroundColor),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.video.description ?? "",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1
                            .copyWith(
                                color: AppColors.textFieldBackgroundColor),
                      ),
                    ],
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
