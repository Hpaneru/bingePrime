import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/screens/password_recovery.dart';
import 'package:binge_prime/screens/signup.dart';
import 'package:binge_prime/widgets/custom_appbar.dart';
import 'package:binge_prime/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String email, password;
  bool showPassword = false, loading = false;

  showSnackbar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).accentColor,
      content: Text(message),
    ));
  }

  showLoading(value) {
    setState(() {
      loading = value;
    });
  }

  tryLoggingIn() {
    if (email == null || password == null) {
      showSnackbar("Please Don't Leave any field Empty");
      return;
    } else if (!firebase.isEmail(email)) {
      showSnackbar("Invalid Email Formate");
      return;
    } else {
      showLoading(true);
      firebase.login(email, password).then((user) {
        showLoading(false);
        Navigator.pushNamedAndRemoveUntil(
            context, "/homeScreen", (predicate) => false);
      }).catchError((err) {
        showLoading(false);
        showSnackbar(err.message);
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomAppbar(
                  "",
                  goBack: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "LOGIN",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            .copyWith(
                                fontSize: 50, color: AppColors.backgroundColor),
                      ),
                      Text(
                        "to start play",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2
                            .copyWith(
                                fontSize: 16, color: AppColors.backgroundColor),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Your Email",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2
                            .copyWith(
                                fontSize: 16, color: AppColors.backgroundColor),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 20.0),
                      Text(
                        "Password",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline2
                            .copyWith(
                                fontSize: 16, color: AppColors.backgroundColor),
                      ),
                      SizedBox(height: 10),
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
                          textCapitalization: TextCapitalization.words,
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
                            suffixIcon: IconButton(
                                icon: Icon(
                                  showPassword ? Mdi.eye : Mdi.eyeOff,
                                  color: AppColors.backgroundColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                }),
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: !showPassword,
                          enableInteractiveSelection: true,
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Forgot',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .caption
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.disabledColor),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Password?',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .caption
                                    .copyWith(
                                        color: AppColors.backgroundColor,
                                        fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PasswordRecoveryScreen()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        onPress: tryLoggingIn,
                        label: "LOGIN",
                        loading: loading,
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Need An account ? ",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1
                                .copyWith(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withAlpha(120)),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Signup',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1
                                    .copyWith(
                                      color: AppColors.backgroundColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
