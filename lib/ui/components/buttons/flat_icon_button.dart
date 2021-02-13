import 'package:flutter/material.dart';

class FlatIconButton extends StatelessWidget {
  const FlatIconButton(
      {@required this.onPressed,
      @required this.icon,
      this.labelText,
      this.iconColor: Colors.white,
      this.textColor: Colors.black});

  final Function onPressed;
  final IconData icon;
  final String labelText;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        labelText,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
