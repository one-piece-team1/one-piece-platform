import 'package:flutter/material.dart';

class TextFormFieldInput extends StatelessWidget {
  TextFormFieldInput({
    this.visible,
    this.validationMsg,
    this.onSaved,
    this.textInputActionStatus,
    this.onFieldSubmitted,
    this.hintText,
    this.iconButtonOnPressed,
  });

  final bool visible;
  final String Function(String) validationMsg;
  final void Function(String) onSaved;
  final TextInputAction textInputActionStatus;
  final void Function(String) onFieldSubmitted;
  final String hintText;
  final VoidCallback iconButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: visible != null ? !visible : false,
      validator: validationMsg,
      onSaved: onSaved,
      textInputAction: textInputActionStatus,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: iconButtonOnPressed != null
            ? IconButton(
                icon: Icon(
                  visible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: iconButtonOnPressed,
              )
            : null,
      ),
    );
  }
}
