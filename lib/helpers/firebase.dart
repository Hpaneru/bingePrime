import 'package:binge_prime/models/user.dart';
import 'package:binge_prime/models/video.dart';
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

  init() async {
    _auth.onAuthStateChanged.listen((user) async {
      _user = user;
    });
  }

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

  Future signup(name, email, password) async {
    var user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    _user = user;
    var info = UserUpdateInfo();
    info.displayName = name;
    await _user.updateProfile(info);
    _user = await _auth.currentUser();
    await manageFirestore();
  }

  Future manageFirestore() async {
    _analytics.logLogin();
    await createUser(User.fromMap({
      "id": _user.uid,
      "name": _user.displayName,
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

  resetPasswordRequest(email) {
    return _auth.sendPasswordResetEmail(email: email);
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

  FirebaseUser getCurrentUser() {
    return _user;
  }

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

  Future<List<Video>> getVideos() async {
    Query videoRef = _firestore.collection("videos");
    QuerySnapshot videos = await videoRef.getDocuments();
    return videos.documents.map((video) => Video.fromMap(video.data)).toList();
  }
}

final firebase = _FirebaseHelper();
