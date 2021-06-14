import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_piece_platform/core/provider/user_provider.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:one_piece_platform/core/models/user/user_model.dart'
    as CurrentUser;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String uid;
String userEmail;
String name;
String imageUrl;

Future<String> signInWithGoogle(BuildContext context) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
  final User user = userCredential.user;

  if (user != null) {
    // Checking if email and name is null
    assert(user.uid != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    UserPreferences().isAuth = true;

    Map<String, dynamic> infoMap = {
      "user": {
        "id": user.uid,
        "username": user.displayName,
        "email": user.email,
//        "licence": "",
//        "role": "",
      }
    };
    CurrentUser.User userInfo = CurrentUser.User.fromJson(infoMap);
// TODO: save user from share preference

    Provider.of<UserProvider>(context, listen: false).setUser(userInfo);

    return 'successful sign in ${user.uid}';
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  UserPreferences().isAuth = false;
// TODO: remove user from share preference
  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User signed out of Google account");
}
