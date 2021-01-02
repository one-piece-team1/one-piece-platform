import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/buttons/social_sign_button.dart';
import 'package:one_piece_platform/ui/components/common/platform_exception_alert_dialog.dart';
import 'package:one_piece_platform/ui/screens/authentication/login_screen.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _username, _email, _password;
  bool showSpinner = false;
  final formKey = new GlobalKey<FormState>();
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final node = FocusScope.of(context);

    // jump between controls with 'tab' in flutter for web
    document.addEventListener('keydown', (dynamic event) {
      if (event.code == 'Tab') {
        event.preventDefault();
      }
    });

    final usernameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      validator: validateUserName,
      onSaved: (value) => _username = value,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
      decoration: buildInputDecoration("User name", Icons.person),
    );
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
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
      decoration: buildInputDecoration("Password", Icons.lock),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
//      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => node.unfocus(),
      decoration: buildInputDecoration("Confirm password", Icons.lock),
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

    var doRegister = () async {
      final form = formKey.currentState;
      setState(() {
        showSpinner = true;
      });
      if (form.validate()) {
        form.save();
        await auth.register(_username, _email, _password).then((response) {
          print("register response[data]");
//          print(response["data"]);
          if (response['status']) {
            print("register response[status]");

////            TODO: getUser
//            User user = response['data'];
//            Provider.of<UserProvider>(context, listen: false).setUser(user);
//            setState(() {
//              showSpinner = false;
//            });
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          } else {
            setState(() {
              showSpinner = false;
            });
            Flushbar(
              title: "Registration Failed",
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                  label("User Name"),
                  SizedBox(
                    height: 8.0,
                  ),
                  usernameField,
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
                  SizedBox(height: 15.0),
                  label("Confirm Password"),
                  confirmPassword,
                  SizedBox(height: 20.0),
                  longButtons("Register", doRegister),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
