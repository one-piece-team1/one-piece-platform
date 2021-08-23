import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/provider/auth.dart';

import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/common/notification_context.dart';
import 'package:one_piece_platform/ui/components/input/text_form_field_input.dart';
import 'package:one_piece_platform/ui/screens/authentication/login_screen.dart';
import 'package:one_piece_platform/ui/screens/authentication/reset_password_screen.dart';
import 'package:one_piece_platform/ui/styles/custom_text_style.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../constants.dart' as k;

enum ActionType {
  Verify,
  SendVerifyCode,
}

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = new GlobalKey<FormState>();
  String _email, _verifyCode, _password;
  bool showSpinner = false;
  bool showVerifyCodeFiled = false;
  ActionType actionType = ActionType.Verify;
  Function actionFn = () {};
  BaseApi baseApi = new BaseApi();
  FocusNode _emailFocusNode;
  FocusNode _verifyCodeFocusNode;
  FocusNode _passwordFocusNode;

  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _emailFocusNode = FocusNode();
    _verifyCodeFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _emailFocusNode.dispose();
    _verifyCodeFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _verifyCodeFocusNode.requestFocus(),
      decoration: buildInputDecoration("Input your email", null),
    );
    final verifyCodeField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      onSaved: (value) => _verifyCode = value,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
      decoration: buildInputDecoration("", null),
    );

    var sendVerifyEmail = () async {
      final form = formKey.currentState;
      setState(() {
        showSpinner = true;
      });
      if (form.validate()) {
        form.save();
        //TODO: forgot password step1
        print('_email');

        print(_email);

        await auth.forgetPasswordStep1(_email).then((response) {
          print(response.toString());
//          print(response["message"].toString());
        });
        // Show verification input
        setState(() {
          // showVerifyCodeFiled = true;
          actionType = ActionType.SendVerifyCode;
          showSpinner = false;
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
    var sendVerifyCode = () async {
      final form = formKey.currentState;
      setState(() {
        showSpinner = true;
      });

      if (form.validate()) {
        print('verify code validated!!');
        form.save();

//        TODO: call send verify code api
        await auth.forgetPasswordStep2(_verifyCode).then((response) {
          print(response.toString());
//          print(response["message"].toString());
          setState(() {
            showSpinner = false;
          });
//        TODO: push and send over verifyCode to reset password screen
          Navigator.pushNamed(context, ResetPasswordScreen.id,
              arguments: {'verifyCode': _verifyCode});
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

    MaterialButton Function(ActionType actionType) showLongButton =
        (actionType) {
      switch (actionType) {
        case ActionType.Verify:
          return longButtons('Confirm', sendVerifyEmail);
        case ActionType.SendVerifyCode:
          return longButtons('Send Verification Code', sendVerifyCode);
        default:
          return longButtons('Confirm', sendVerifyEmail);
      }
    };

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(children: [
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.06,
                vertical: screenSize.height * 0.15,
              ),
              child: Container(
                // alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Center(
                        child: Text(
                          'Please Input your email to get your password back',
                          style: CustomTextStyle.body1(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      label("Email"),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      emailField,
                      SizedBox(
                        height: screenSize.height * 0.1,
                      ),
                      Visibility(
                        visible: actionType.toString() == 'ActionType.SendVerifyCode',
                        child: Column(
                          children: [
                            label("Verify Code"),
                            SizedBox(
                              height: screenSize.height * 0.01,
                            ),
                            Container(width: 100.0, child: verifyCodeField),
                          ],
                        ),
                      ),

                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: showVerifyCodeFiled
                      //       ? longButtons("Confirm", sendVerifyCode)
                      //       : longButtons("Send Verification Code", sendVerifyEmail),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text('Forgot Password'), // You can add title here
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, LoginScreen.id),
              ),
              backgroundColor: k.kPrimaryBlue,
              elevation: 0.0, //No shadow
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: showLongButton(actionType),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.transparent,
      ),
    );
  }
}
