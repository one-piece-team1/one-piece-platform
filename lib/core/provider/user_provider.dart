import 'package:flutter/foundation.dart';
import 'package:one_piece_platform/core/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();
  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
