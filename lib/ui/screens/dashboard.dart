import 'package:flushbar/flushbar.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/provider/user_provider.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';
import 'package:one_piece_platform/ui/screens/authentication/login_screen.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  static const String id = 'dashboard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    Future<User> _getUserData() => UserPreferences().getUser();
    var checkUserIsLoggedIn = () async {
      User _userData = await _getUserData();

      if (_userData.id == null || user.id == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.id, (Route<dynamic> route) => false);
      }
    };
    checkUserIsLoggedIn();
    var doLogout = () async {
      UserPreferences().removeUser();

      await auth.logout().then((response) {
        if (response['status']) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LoginScreen.id, (Route<dynamic> route) => false);
        } else {
          Flushbar(
            title: "Logout Failed",
            message: response["message"].toString(),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    };
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text("DASHBOARD PAGE"),
          elevation: 0.1,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(child: Text(user.email ?? "no email")),
            SizedBox(height: 100),
            RaisedButton(
              onPressed: doLogout,
              child: Text("Logout"),
              color: Colors.lightBlueAccent,
            )
          ],
        ),
      ),
    );
  }
}
