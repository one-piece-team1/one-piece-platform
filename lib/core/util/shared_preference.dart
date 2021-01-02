import 'package:one_piece_platform/core/models/auth_model.dart';
import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveToken(Auth auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', "Bearer " + auth.accessToken);
    print("token preference");
  }

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId);
    prefs.setString("username", user.username);
    prefs.setString("email", user.email);
    prefs.setString("licence", user.licence);
    prefs.setString("role", user.role);

    print("user preference");
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId");
    String username = prefs.getString("username");
    String email = prefs.getString("email");
    String licence = prefs.getString("licence");
    String role = prefs.getString("role");

    return User(
        userId: userId,
        username: username,
        email: email,
        licence: licence,
        role: role);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("licence");
    prefs.remove("role");
  }

  void removeAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("accessToken");
  }

  Future<Auth> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("accessToken");
    return Auth(accessToken: accessToken);
  }
}
