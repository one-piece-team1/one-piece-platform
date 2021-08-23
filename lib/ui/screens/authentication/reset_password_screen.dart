import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/provider/auth.dart';

import 'package:one_piece_platform/core/util/validators.dart';
import 'package:one_piece_platform/core/util/widgets.dart';
import 'package:one_piece_platform/ui/components/common/notification_context.dart';
import 'package:one_piece_platform/ui/components/input/text_form_field_input.dart';
import 'package:one_piece_platform/ui/screens/authentication/forgot_password_screen.dart';
import 'package:one_piece_platform/ui/styles/custom_text_style.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../constants.dart' as k;
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = new GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  String _password, _confirmPassword;
  bool showSpinner = false;
  BaseApi baseApi = new BaseApi();

  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;

  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _confirmPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    var screenSize = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final passwordField = TextFormFieldInput(
        visible: _passwordVisible,
        validationMsg: validateNewPassword,
        onSaved: (value) => _password = value,
        textInputActionStatus: TextInputAction.done,
        onFieldSubmitted: (_) => _passwordFocusNode.unfocus(),
        hintText: 'New password',
        iconButtonOnPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        });
    final confirmPasswordField = TextFormFieldInput(
        visible: _passwordVisible,
        validationMsg: (value) =>
            validateConfirmPassword(value, _passwordController.text),
        controller: _passwordController,
        onSaved: (value) => _confirmPassword = value,
        textInputActionStatus: TextInputAction.done,
        onFieldSubmitted: (_) => _passwordFocusNode.unfocus(),
        hintText: 'Confirm new password',
        iconButtonOnPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        });

    var resetPassword = () async {
      final form = formKey.currentState;
      setState(() {
        showSpinner = true;
      });
      if (form.validate()) {
        form.save();

        // TODO: call forgot password step3 api

        await auth
            .forgetPasswordStep3(arguments['verifyCode'], _password)
            .then((response) {
          print(response.toString());
          Navigator.pushNamed(context, LoginScreen.id);

        });
        // Show verification input
        setState(() {
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

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.06,
                  vertical: screenSize.height * 0.2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    label("New Password"),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    passwordField,
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    label("Confirm Password"),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    confirmPasswordField,
                  ],
                ),
              ),
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text('Reset Password'), // You can add title here
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, ForgotPasswordScreen.id),
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
          child: longButtons("Confirm", resetPassword),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.transparent,
      ),
    );
    ;
  }
}
