import 'package:binge_prime/helpers/colors.dart';
import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/widgets/custom_appbar.dart';
import 'package:binge_prime/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String name, email, password;
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

  registerUser() {
    if (name == null || email == null || password == null) {
      showSnackbar("Please Don't Leave any field Empty");
      return;
    } else if (!firebase.isEmail(email)) {
      showSnackbar("Invalid Email Formate");
      return;
    } else {
      showLoading(true);
      firebase.signup(name, email, password).then((data) {
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
                      SizedBox(height: 30),
                      Text(
                        "Sign Up",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            .copyWith(
                                fontSize: 50, color: AppColors.backgroundColor),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        "Your Name",
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
                          ),
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                      SizedBox(height: 50),
                      CustomButton(
                        onPress: registerUser,
                        label: "SIGNUP",
                        loading: loading,
                        color: AppColors.customButtonColor,
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
