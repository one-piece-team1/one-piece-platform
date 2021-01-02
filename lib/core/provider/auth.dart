import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:one_piece_platform/core/api/user_api.dart';
import 'package:one_piece_platform/core/models/auth_model.dart';
import 'package:one_piece_platform/core/models/user_model.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredStatus => _registeredStatus;

  Future<Map<String, User>> login(String email, String password) async {
    var result;
    final Map<String, dynamic> loginData = {
      'user': {'email': email, 'password': password}
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await UserApi().logInUser(loginData);
    var responseData = response.data;
    if (response.statusCode == 201) {
      Auth token = Auth.fromJson(responseData.accessToken);
      UserPreferences().saveToken(token);

// get user's information
      Response getUserRes = await UserApi().logInUser(loginData);
      var getUserData = getUserRes.data.message;
      User authUser = User.fromJson(getUserData.user);
      UserPreferences().saveUser(authUser);
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successfully login',
        'data': authUser
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        // TODO: where's the error
        'message': responseData['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String userName, String email, String password) async {
    final Map<String, dynamic> registrationData = {
      'username': userName,
      'email': email,
      'password': password,
    };

    _registeredStatus = Status.Registering;
    notifyListeners();

    return await UserApi()
        .registerUser(registrationData)
        .then(onValue)
        .catchError(onError);
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
//   TODO: need to make sure the responseData is right
    print(response);
    final Map<String, dynamic> responseData = response.data;

    if (response.statusCode == 201) {
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': responseData
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData["error"]
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
