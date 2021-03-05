String validateUserName(String value) {
  String _msg;
  if (value.isEmpty) {
    _msg = "User name is required";
  } else if (value.length < 4) {
    _msg = "User name must greater than 4";
  }
  return _msg;
}

String validateEmail(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Email is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid email";
  }
  return _msg;
}

String validatePassword(String value) {
  String _msg;
  RegExp regex =
      new RegExp(r'^((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  if (value.isEmpty) {
    _msg = "Password is required";
  } else if (!regex.hasMatch(value)) {
    _msg =
        "Password must contain characters with uppercase, lowercase and numbers";
  } else if (value.length < 8) {
    _msg = 'Password length must greater than 8';
  }
  return _msg;
}

String validateNewPassword(String value) {
  String _msg;
  RegExp regex =
      new RegExp(r'^((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  if (!regex.hasMatch(value)) {
    _msg =
        "Password must contain characters with uppercase, lowercase and numbers";
  } else if (value.length < 8) {
    _msg = 'Password length must greater than 8';
  }
  return _msg;
}

String validateConfirmPassword(String value, String password) {
  String _msg;
  RegExp regex =
      new RegExp(r'^((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  if (value.isEmpty) {
    _msg = "Confirm password is required";
  } else if (!regex.hasMatch(value)) {
    _msg =
        "Password must contain characters with uppercase, lowercase and numbers";
  } else if (value.length < 8) {
    _msg = 'Password length must greater than 8';
  } else if (value != password) {
    print('value $value');
    print('password $password');
    _msg = 'Password and Confirm Password are not the same';
  }
  return _msg;
}
