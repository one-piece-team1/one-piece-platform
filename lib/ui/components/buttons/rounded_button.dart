import 'package:flutter/material.dart';

import '../../constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.textColor: Colors.white,
        this.color,
        this.title,
        this.shape,
        @required this.onPressed});

  final Color color;
  final String title;
  final Function onPressed;
  final Color textColor;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: color,
      minWidth: 200.0,
      height: 42.0,
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      shape: shape,
    );
  }
}
