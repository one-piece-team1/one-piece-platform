import 'package:flutter/material.dart';

class RoundedButtonIcon extends StatelessWidget {
  RoundedButtonIcon(
      {this.textColor: Colors.white,
      this.color,
      this.title,
      this.shape,
      this.padding: 15.0,
      this.icon,
      this.iconColor,
      this.iconSize,
        this.constraints,
      @required this.onPressed});
  final double padding;
  final Color color;
  final String title;
  final Function onPressed;
  final Color textColor;
  final Color iconColor;
  final ShapeBorder shape;
  final IconData icon;
  final double iconSize;
final BoxConstraints constraints ;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      elevation: 2.0,
      fillColor: color,
      child: Icon(
        // icon,
        icon,
        size: iconSize,
        color: iconColor,
      ),
      padding: EdgeInsets.all(padding),
      shape: shape,
      constraints: constraints,
    );
  }
}
