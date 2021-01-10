import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/provider/auth.dart';

import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/common/notification_context.dart';
import 'package:one_piece_platform/ui/components/input/text_form_field_input.dart';
import 'package:one_piece_platform/ui/styles/CustomTextStyle.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../constants.dart' as k;

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = new GlobalKey<FormState>();
  String _email, _verifyCode, _password;
  bool showSpinner = false;
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
      decoration:
          buildInputDecoration("Input your verify code from Email", null),
    );
    final passwordField = TextFormFieldInput(
        visible: _passwordVisible,
        validationMsg: validateNewPassword,
        onSaved: (value) => _password = value,
        textInputActionStatus: TextInputAction.done,
        onFieldSubmitted: (_) => _passwordFocusNode.unfocus(),
        hintText: 'Input your new password',
        iconButtonOnPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        });

    var doForgotPassword = () async {
      final form = formKey.currentState;
      setState(() {
        showSpinner = true;
      });
      if (form.validate()) {
        form.save();
        //TODO: forgot password step1

        await auth.forgetPasswordStep1(_email).then((response) {
          print(response["message"].toString());
        });

        //TODO: forgot password step2
        final Map<String, String> forgetPassStep2Data = {
          'key': _verifyCode,
        };
        //TODO: forgot password step3
        final Map<String, String> forgetPassStep3Data = {
          'key': _verifyCode,
          'password': _password,
        };
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(children: [
          Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.06,
                vertical: screenSize.height * 0.1,
              ),
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
                    height: screenSize.height * 0.01,
                  ),
//                  label("Verify Code"),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
//                  verifyCodeField,
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
//                  label("New Password"),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
//                  passwordField,
                  SizedBox(
                    height: screenSize.height * 0.4,
                  ),
                  longButtons("Confirm ", doForgotPassword),
                ],
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.grey[800],
              elevation: 0.0, //No shadow
            ),
          )
        ]),
      ),
    );
    ;
  }
}
