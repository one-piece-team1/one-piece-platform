import 'dart:async';
import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/provider/user_provider.dart';
import 'package:one_piece_platform/core/util/firebase_auth.dart';
import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/buttons/social_sign_button.dart';
import 'package:one_piece_platform/ui/components/common/notification_context.dart';
import 'package:one_piece_platform/ui/components/common/platform_exception_alert_dialog.dart';
import 'package:one_piece_platform/ui/components/input/text_form_field_input.dart';
import 'package:one_piece_platform/ui/screens/authentication/forgot_password_screen.dart';
import 'package:one_piece_platform/ui/screens/tabs/tab_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import '../../constants.dart' as k;
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
  BaseApi baseApi = new BaseApi();

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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
    var screenSize = MediaQuery.of(context).size;

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
      decoration: buildInputDecoration("Enter your Email", null),
    );
    final passwordField = TextFormFieldInput(
        visible: _passwordVisible,
        validationMsg: validatePassword,
        onSaved: (value) => _password = value,
        textInputActionStatus: TextInputAction.done,
        onFieldSubmitted: (_) => _passwordFocusNode.unfocus(),
        hintText: 'Enter your password',
        iconButtonOnPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        });

    void _showSignInError(BuildContext context, PlatformException exception) {
      PlatformExceptionAlertDialog(
        title: 'Login failed',
        exception: exception,
      ).show(context);
    }

    Future<void> _signInWithGoogle(BuildContext context) async {
      try {
        await signInWithGoogle(context).then((result) {
          print('Sign in google result $result');
          // TODO: need to send the user's data to our backend

          Navigator.pushNamed(context, DashBoard.id);
        }).catchError((error) {
          print('_signInWithGoogle Error: $error');
        });
      } on PlatformException catch (e) {
        if (e.code != 'ERROR_ABORTED_BY_USER') {
          _showSignInError(context, e);
        }
      }
    }

    Future<void> _signInWithFacebook(BuildContext context) async {
      try {
        await baseApi.launchOAuthURL('facebook');
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

            Navigator.pushReplacementNamed(context, TabPage.id);
          } else {
            setState(() {
              showSpinner = false;
            });
            showOverlayNotification((context) {
              return NotificationContent(
                title: "Login Failed",
                subtitle: response["data"].toString(),
              );
            }, duration: kNotificationDuration);
          }
        });
      } else {
        setState(() {
          showSpinner = false;
        });
        showOverlayNotification((context) {
          return NotificationContent(
            title: "Invalid form",
            subtitle: "Please Complete the form properly",
          );
        }, duration: kNotificationDuration);
      }
    };
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: <Widget>[
              Container(
                height: screenSize.height * 0.2,
                color: Colors.grey[600],
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.height * 0.06,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: screenSize.height * 0.1,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      Text(
                        'Login with',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.0,
                          fontSize: screenSize.height * 0.02,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            googleOAuth,
//                      fbOAuth,
//                appleOAuth,
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(children: <Widget>[
                        Expanded(child: Divider()),
                        Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenSize.height * 0.025,
                            color: Colors.grey[700],
                          ),
                        ),
                        Expanded(child: Divider()),
                      ]),
                      SizedBox(height: screenSize.height * 0.02),
                      label("Email"),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      emailField,
                      SizedBox(height: screenSize.height * 0.02),
                      label("Password"),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      passwordField,
                      SizedBox(height: screenSize.height * 0.025),
                      RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          style: k.kTextDefaultStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Forgot password',
                                style: k.kLinkStyle,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, ForgotPasswordScreen.id);
                                  }),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      longButtons("Login", doLogin),
                    ],
                  ),
                ),
              ),
              new Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text(''), // You can add title here
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor:
                      Colors.grey[800], //You can make this transparent
                  elevation: 0.0, //No shadow
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
