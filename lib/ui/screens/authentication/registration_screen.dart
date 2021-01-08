import 'dart:async';
import 'dart:html';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/util/firebase_auth.dart';
import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/buttons/social_sign_button.dart';
import 'package:one_piece_platform/ui/components/common/platform_exception_alert_dialog.dart';
import 'package:one_piece_platform/ui/screens/authentication/login_screen.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

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

  bool _passwordVisible;
  bool _confirmPasswordVisible;

  BaseApi baseApi = new BaseApi();
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
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
      decoration: buildInputDecoration("輸入你的使用者名稱", null),
    );
    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
      decoration: buildInputDecoration("輸入你的Email", null),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: !_passwordVisible,
      validator: validatePassword,
      onSaved: (value) => _password = value,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
      decoration: InputDecoration(
        hintText: '請輸入你的密碼',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => validateConfirmPassword(value, _password),
      obscureText: !_confirmPasswordVisible,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _confirmPasswordFocusNode.unfocus(),
      decoration: InputDecoration(
        hintText: '再次輸入你的密碼',
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
          icon: Icon(
            _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
        ),
      ),
    );

    void _showRegisterError(BuildContext context, PlatformException exception) {
      PlatformExceptionAlertDialog(
        title: '註冊失敗',
        exception: exception,
      ).show(context);
    }

    Future<void> _signInWithGoogle(BuildContext context) async {
      try {
        await signInWithGoogle(context).then((result) {
          print('sign in google result $result');
          // TODO: need to send the user's data to our backend

          Navigator.pushNamed(context, DashBoard.id);
        }).catchError((error) {
          print('_signInWithGoogle Error: $error');
        });
      } on PlatformException catch (e) {
        if (e.code != 'ERROR_ABORTED_BY_USER') {
          _showRegisterError(context, e);
        }
      }
    }

    Future<void> _signInWithFacebook(BuildContext context) async {
      try {
        await baseApi.launchOAuthURL('facebook');
      } on PlatformException catch (e) {
        if (e.code != 'ERROR_ABORTED_BY_USER') {
          _showRegisterError(context, e);
        }
      }
    }

//    void _signInWithEmail(BuildContext context) async {
//      try {
////        await manager.signInWithFacebook();
//      } on PlatformException catch (e) {
//        if (e.code != 'ERROR_ABORTED_BY_USER') {
//          _showRegisterError(context, e);
//        }
//      }
//    }

    final googleOAuth = SocialSignInButton(
      assetName: 'images/google-logo.png',
      color: Colors.white,
      onPressed: () => _signInWithGoogle(context),
    );
//    final fbOAuth = SocialSignInButton(
//      assetName: 'images/facebook-logo.png',
//      color: Color(0xFF334D92),
//      onPressed: () => _signInWithFacebook(context),
//    );

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
          if (response['status']) {
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          } else {
            setState(() {
              showSpinner = false;
            });
            Flushbar(
              title: "註冊失敗",
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
          title: "欄位內容有誤",
          message: "請完成欄位",
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
                    '使用以下連結註冊',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.0,
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
//                        fbOAuth, // fb signIn not support in Flutter web
//                appleOAuth,
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(children: <Widget>[
                    Expanded(child: Divider()),
                    Text(
                      '或',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    Expanded(child: Divider()),
                  ]),
                  SizedBox(height: 15.0),
                  label("使用者名稱"),
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
                  label("密碼"),
                  SizedBox(
                    height: 8.0,
                  ),
                  passwordField,
                  SizedBox(height: 15.0),
                  label("確認密碼"),
                  confirmPassword,
                  SizedBox(height: 20.0),
                  longButtons("註冊", doRegister),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
