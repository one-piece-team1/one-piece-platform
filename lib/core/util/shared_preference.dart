import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  set saveToken(String accessToken) {
    _sharedPrefs.setString('accessToken', "Bearer " + accessToken);
    print("token preference");
  }

  set isAuth(bool isAuth) {
    _sharedPrefs.setBool("auth", isAuth);
  }

  set saveUser(User user) {
    _sharedPrefs.setString("id", user.id);
    _sharedPrefs.setString("username", user.username);
    _sharedPrefs.setString("email", user.email);
    _sharedPrefs.setString("licence", user.licence);
    _sharedPrefs.setString("role", user.role);

    print("user preference");
  }

  Future<User> getUser() async {
    String id = _sharedPrefs.getString("id");
    String username = _sharedPrefs.getString("username");
    String email = _sharedPrefs.getString("email");
    String licence = _sharedPrefs.getString("licence");
    String role = _sharedPrefs.getString("role");

    return User(
        id: id, username: username, email: email, licence: licence, role: role);
  }

  void removeUser() {
    _sharedPrefs.remove("auth");
    _sharedPrefs.remove("name");
    _sharedPrefs.remove("email");
    _sharedPrefs.remove("licence");
    _sharedPrefs.remove("role");
  }

  void removeAuth() {
    _sharedPrefs.remove("accessToken");
  }

  String get getToken {
    String accessToken = _sharedPrefs.getString("accessToken") ?? "";
    return accessToken;
  }
}
