import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/widgets/custom_appbar.dart';
import 'package:binge_prime/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  bool autoValidate = false;
  String email;
  bool loading = false;

  showSnackbar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).accentColor,
      content: Text(message),
    ));
  }

  proceed() async {
    if (email == null) {
      showSnackbar("Please Enter Email");
      return;
    } else if (!firebase.isEmail(email)) {
      showSnackbar("Invalid Email Format");
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await firebase.resetPasswordRequest(email);
      Navigator.pushNamedAndRemoveUntil(
          context, "/introScreen", (predicate) => false);
      setState(() {
        loading = false;
      });
    } catch (e) {
      if (e is PlatformException) {
        print(e);
        if (e.code == "ERROR_USER_NOT_FOUND") {
          showSnackbar("Email doesn't exist on our system");
        }
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.gradientColors,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomAppbar("", goBack: true),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Password Recovery",
                          style: Theme.of(context).primaryTextTheme.headline5),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.customButtonColor,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(color: AppColors.backgroundColor),
                          cursorColor: AppColors.backgroundColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: AppColors.textFieldBackgroundColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.customButtonColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.customButtonColor),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              email = (value ?? "").trim();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Enter the email address to which the account was registered",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .caption
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      CustomButton(
                        loading: loading,
                        borderRadius: false,
                        onPress: proceed,
                        label: "RECOVER THE PASSWORD",
                      ),
                      SizedBox(height: 8)
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
