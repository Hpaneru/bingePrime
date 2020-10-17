import 'package:binge_prime/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class _FirebaseHelper {
  FirebaseMessaging _messaging = FirebaseMessaging();
  FirebaseAnalytics _analytics = FirebaseAnalytics();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore();
  FirebaseUser _user;
  User _me;

  bool isEmail(String em) => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(em);

  Future<FirebaseUser> login(email, password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future signup(email, password) async {
    var user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    _user = user;
    await manageFirestore();
  }

  Future manageFirestore() async {
    _analytics.logLogin();
    await createUser(User.fromMap({
      "id": _user.uid,
      "email": _user.email ?? "",
      "token": await _messaging.getToken(),
    }));
    _me = await getUserInfo();
  }

  Future createUser(User userData) {
    return _firestore
        .collection("users")
        .document(userData.id)
        .setData(userData.toMap(), merge: true);
  }

  Future<User> getUserInfo({uid}) async {
    if (uid == null) {
      if (_me != null) {
        return _me;
      }
      uid = _user.uid;
    }
    DocumentSnapshot user =
        await _firestore.collection("users").document(uid).get();
    return User.fromMap(user.data);
  }

  // User getCurrentUser() {
  //   return _user;
  // }

  Stream<FirebaseUser> getUserStateListener() {
    return _auth.onAuthStateChanged;
  }

  Future logout() async {
    _user = null;
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

final firebase = _FirebaseHelper();
