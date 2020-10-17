import 'package:binge_prime/helpers/firebase.dart';
import 'package:binge_prime/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  String email, password;
  bool showPassword = false, autoValidate = false, loading = false;

  showSnackbar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoading(true);
      firebase.signup(email, password).then((data) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100),
                        Text(
                          "SIGNUP",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        TextFormField(
                          autovalidate: autoValidate,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.caption,
                            labelText: "YOUR EMAIL",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withAlpha(120)),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty)
                              return "Mandatory Field";
                            else if (!firebase.isEmail(value))
                              return "Invalid Email";
                            return null;
                          },
                          onSaved: (value) {
                            email = (value ?? "").trim();
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          autovalidate: autoValidate,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.caption,
                            labelText: "PASSWORD",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withAlpha(120)),
                            suffixIcon: IconButton(
                                icon: Icon(showPassword ? Mdi.eye : Mdi.eyeOff),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                }),
                          ),
                          validator: (value) {
                            if (value.isEmpty) return "Mandatory Field";

                            if (value.length > 20) return "Password Too Long";
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                          obscureText: !showPassword,
                          enableInteractiveSelection: true,
                        ),
                        SizedBox(height: 100),
                        CustomButton(
                          onPress: registerUser,
                          label: "SIGNUP",
                          loading: loading,
                        ),
                      ],
                    ),
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
