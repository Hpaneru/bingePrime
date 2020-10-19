import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar(this.title,
      {this.titleWidget, this.actions, this.goBack = false, this.color});
  final bool goBack;
  final String title;
  final Color color;
  final Widget titleWidget;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      alignment: Alignment.center,
      height: 44,
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                if (goBack)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushNamed("/homeScreen");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Mdi.arrowLeft,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                Expanded(
                  child: titleWidget ??
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          title,
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                      ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions != null ? actions : [],
            ),
          )
        ],
      ),
    );
  }
}
