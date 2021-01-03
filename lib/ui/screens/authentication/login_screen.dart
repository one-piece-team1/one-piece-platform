import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/provider/user_provider.dart';
import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/buttons/social_sign_button.dart';
import 'package:one_piece_platform/ui/components/common/platform_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  bool showSpinner = false;
  final formKey = new GlobalKey<FormState>();

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    // jump between controls with 'tab' in flutter for web
    document.addEventListener('keydown', (dynamic event) {
      if (event.code == 'Tab') {
        event.preventDefault();
      }
    });

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
      decoration: buildInputDecoration("Email", Icons.email),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: validatePassword,
      onSaved: (value) => _password = value,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _passwordFocusNode.unfocus(),
      decoration: buildInputDecoration("Password", Icons.lock),
    );

    void _showSignInError(BuildContext context, PlatformException exception) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: exception,
      ).show(context);
    }

    Future<void> _signInWithGoogle(BuildContext context) async {
      try {
//        await manager.signInWithGoogle();
      } on PlatformException catch (e) {
        if (e.code != 'ERROR_ABORTED_BY_USER') {
          _showSignInError(context, e);
        }
      }
    }

    Future<void> _signInWithFacebook(BuildContext context) async {
      try {
//        await manager.signInWithFacebook();
      } on PlatformException catch (e) {
        if (e.code != 'ERROR_ABORTED_BY_USER') {
          _showSignInError(context, e);
        }
      }
    }

//    void _signInWithEmail(BuildContext context) async {
//      try {
////        await manager.signInWithFacebook();
//      } on PlatformException catch (e) {
//        if (e.code != 'ERROR_ABORTED_BY_USER') {
//          _showSignInError(context, e);
//        }
//      }
//    }

    final googleOAuth = SocialSignInButton(
      assetName: 'images/google-logo.png',
      color: Colors.white,
      onPressed: () => _signInWithGoogle(context),
    );
    final fbOAuth = SocialSignInButton(
      assetName: 'images/facebook-logo.png',
      color: Color(0xFF334D92),
      onPressed: () => _signInWithFacebook(context),
    );

    // TODO: apple sign in
//    final appleOAuth =  SocialSignInButton(
//      assetName: 'images/apple-logo.png',
//      color: Color(0xFF334D92),
//      onPressed: showSpinner ? null : () => _signInWithApple(context),
//    );

    var doLogin = () async {
      final form = formKey.currentState;
      setState(() {
        showSpinner = true;
      });
      if (form.validate()) {
        form.save();
        await auth.login(_email, _password).then((response) {
          if (response['status']) {
            User user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacementNamed(context, DashBoard.id);
          } else {
            setState(() {
              showSpinner = false;
            });
            Flushbar(
              title: "Login Failed",
              message: response["data"].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        setState(() {
          showSpinner = false;
        });
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 3),
        ).show(context);
      }
    };
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Text(
                  'CONNECT WITH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[700],
                  ),
                ),
                Divider(),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      googleOAuth,
                      fbOAuth,
//                appleOAuth,
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  Expanded(child: Divider()),
                ]),
                SizedBox(height: 15.0),
                label("Email"),
                SizedBox(
                  height: 8.0,
                ),
                emailField,
                SizedBox(height: 15.0),
                label("Password"),
                SizedBox(
                  height: 8.0,
                ),
                passwordField,
                SizedBox(height: 20.0),
                longButtons("Login", doLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
