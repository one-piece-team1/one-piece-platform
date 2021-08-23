import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/util/firebase_auth.dart';
import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/buttons/social_sign_button.dart';
import 'package:one_piece_platform/ui/components/common/notification_context.dart';
import 'package:one_piece_platform/ui/components/common/platform_exception_alert_dialog.dart';
import 'package:one_piece_platform/ui/components/input/text_form_field_input.dart';
import 'package:one_piece_platform/ui/constants.dart' as k;
import 'package:one_piece_platform/ui/screens/authentication/login_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
    var screenSize = MediaQuery.of(context).size;

    AuthProvider auth = Provider.of<AuthProvider>(context);


    final usernameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      validator: validateUserName,
      controller: _usernameController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
      decoration: buildInputDecoration("Enter your user name", null),
    );
    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
      decoration: buildInputDecoration("Enter your Email", null),
    );
    final passwordField = TextFormFieldInput(
        visible: _passwordVisible,
        validationMsg: validatePassword,
        controller: _passwordController,
        textInputActionStatus: TextInputAction.done,
        onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
        hintText: 'Enter your password',
        iconButtonOnPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        });

    final confirmPassword = TextFormFieldInput(
        visible: _confirmPasswordVisible,
//        onSaved: (value) => value,
        validationMsg: (value) =>
            validateConfirmPassword(value, _passwordController.text),
        textInputActionStatus: TextInputAction.done,
        onFieldSubmitted: (_) => _confirmPasswordFocusNode.unfocus(),
        hintText: 'Enter your password again',
        iconButtonOnPressed: () {
          setState(() {
            _confirmPasswordVisible = !_confirmPasswordVisible;
          });
        });

    void _showRegisterError(BuildContext context, PlatformException exception) {
      PlatformExceptionAlertDialog(
        title: 'Register failed',
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
        await auth
            .register(_usernameController.text, _emailController.text,
                _passwordController.text)
            .then((response) {
          if (response['status']) {
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          } else {
            setState(() {
              showSpinner = false;
            });
            showOverlayNotification((context) {
              return NotificationContent(
                title: "Registration failed",
                subtitle: response["data"].toString(),
              );
            }, duration: k.kNotificationDuration);
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
        }, duration: k.kNotificationDuration);
//        Flushbar(
//          title: "The form input is invalid",
//          message: "Please finish the inputs",
//          ,
//        ).show(context);
      }
    };

    return SafeArea(
      child: Scaffold(
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
                  decoration: k.kLinearDecoColor,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.06,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
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
                                child: Image.asset('images/ahoy_icon.png'),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            Text(
                              'Register with',
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
//                        fbOAuth, // fb signIn not support in Flutter web
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
                            label("User Name"),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            usernameField,
                            SizedBox(height: screenSize.height * 0.02),
                            label("Email"),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            emailField,
                            SizedBox(height: screenSize.height * 0.02),
                            label("Password"),
                            SizedBox(height: screenSize.height * 0.01),
                            passwordField,
                            SizedBox(height: screenSize.height * 0.02),
                            label("Confirm your password"),
                            SizedBox(height: screenSize.height * 0.01),
                            confirmPassword,
                            SizedBox(height: screenSize.height * 0.025),
                            longButtons("Register", doRegister),
                            SizedBox(height: screenSize.height * 0.02),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: k.kTextDefaultStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'By clicking Sign Up, you agree to our '),
                                    TextSpan(
                                        text: 'Terms of Service',
                                        style: k.kLinkStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Terms of Service');
                                          }),
                                    TextSpan(text: ' and that you have read our '),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: k.kLinkStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Privacy Policy');
                                          }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.01),
                            Divider(),
                            SizedBox(height: screenSize.height * 0.01),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: k.kTextDefaultStyle,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Already have an account?  '),
                                    TextSpan(
                                        text: 'Login',
                                        style: k.kLinkStyle,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                                context, LoginScreen.id);
                                          }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
