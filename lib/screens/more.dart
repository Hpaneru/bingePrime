import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/models/user.dart';
import 'package:binge_prime/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  User user;
  confirmLogOut() {
    showDialog(
        context: context,
        builder: (context) {
          return ConfirmationDialog(
              description: "You are about to sign out",
              title: "Are you sure",
              popAfterDone: false,
              onConfirm: () async {
                Navigator.pop(context);
                firebase.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/introScreen", (predicate) => false);
              });
        });
  }

  getListTile(
      {Function onTap,
      Widget leading,
      Widget title,
      bool divider,
      Widget trailing}) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[leading, SizedBox(width: 20), title],
                ),
                trailing ?? SizedBox()
              ],
            ),
          ),
        ),
        if (divider) Divider(height: 1)
      ],
    );
  }

  @override
  void initState() {
    firebase.getUserInfo().then((data) {
      setState(() {
        this.user = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: <Widget>[
                  // CustomAppbar(
                  //   "",
                  //   goBack: true,
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: AppColors.gradientColors,
                              ),
                            ),
                            accountName: Text(user.name),
                            accountEmail: Text(user.email),
                          ),
                          getListTile(
                            onTap: confirmLogOut,
                            leading: Icon(Mdi.logout,
                                size: 18, color: AppColors.primaryColor),
                            title: Text(
                              "Log Out",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1
                                  .copyWith(
                                    color: AppColors.black,
                                  ),
                            ),
                            divider: true,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
