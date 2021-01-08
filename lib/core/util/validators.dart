String validateUserName(String value) {
  String _msg;
  if (value.isEmpty) {
    _msg = "使用者名稱為必填欄位";
  } else if (value.length < 4) {
    _msg = "使用者名稱長度須大於等於4";
  }
  return _msg;
}

String validateEmail(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Email為必填欄位";
  } else if (!regex.hasMatch(value)) {
    _msg = "請提供有效的email";
  }
  return _msg;
}

String validatePassword(String value) {
  String _msg;
  RegExp regex =
      new RegExp(r'^((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  if (value.isEmpty) {
    _msg = "密碼為必填欄位";
  } else if (!regex.hasMatch(value)) {
    _msg = "密碼必須包含英文大小寫及數字";
//        "Password must contain characters with uppercase, lowercase and numbers";
  } else if (value.length < 8) {
    _msg = '密碼長度須大於8';
  }
  return _msg;
}

String validateConfirmPassword(String value, String password) {
  String _msg;
  RegExp regex =
      new RegExp(r'^((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
  if (value.isEmpty) {
    _msg = "確認密碼為必填欄位";
  } else if (!regex.hasMatch(value)) {
    _msg = "密碼必須包含英文大小寫及數字";
//        "Password must contain characters with uppercase, lowercase and numbers";
  } else if (value.length < 8) {
    _msg = '密碼長度須大於8';
  } else if (value != password) {
    _msg = '密碼欄位輸入不一致';
  }
  return _msg;
}
