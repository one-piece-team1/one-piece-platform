import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String imageURL;

  Thumbnail(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imageURL,
            ),
          ),
        ),
      ),
    );
  }
}
