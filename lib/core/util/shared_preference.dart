import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId);
    prefs.setString("username", user.username);
    prefs.setString("email", user.email);
    prefs.setString("licence", user.licence);
    prefs.setString("role", user.role);
//    prefs.setString("token", user.token);
//    prefs.setString("refreshToken", user.refreshToken);

    print("object prefere");
// don't need to commit() anymore
//    return prefs.commit(;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId");
    String username = prefs.getString("username");
    String email = prefs.getString("email");
    String licence = prefs.getString("licence");
    String role = prefs.getString("role");
//    String token = prefs.getString("token");
//    String refreshToken = prefs.getString("refreshToken");

    return User(
        userId: userId,
        username: username,
        email: email,
        licence: licence,
        role: role
//        token: token,
//        refreshToken: refreshToken);
        );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("licence");
    prefs.remove("role");
//    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
