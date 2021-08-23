import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle headline3(BuildContext context) {
    return Theme.of(context).textTheme.headline3.copyWith(
        fontSize: 16.0,
        fontFamily: 'Noto Sans TC',
        fontWeight: FontWeight.normal,
        color: Colors.black);
  }

  static TextStyle headline4(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(fontSize: 34.0);
  }

  static TextStyle headline5(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(fontSize: 24.0);
  }

  static TextStyle headline6(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(fontSize: 20.0);
  }

  static TextStyle body1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15.0);
  }
}
