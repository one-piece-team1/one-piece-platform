import 'package:flutter/material.dart';
import 'package:one_piece_platform/ui/components/common/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetName,
    Color color,
    @required VoidCallback onPressed,
  })  : assert(assetName != null),
        super(
          child: RawMaterialButton(
            child: Image.asset(assetName),
            onPressed: onPressed,
          ),
          shape: CircleBorder(),
          color: color,
        );
}
