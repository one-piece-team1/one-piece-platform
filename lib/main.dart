import 'package:flutter/material.dart';
import 'package:one_piece_platform/screens/authentication/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(OnePiecePlatform());
}

class OnePiecePlatform extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context)=>LoginScreen(),
      },
    );
  }
}
