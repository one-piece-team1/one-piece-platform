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

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    final Map<String, String> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await UserApi().logInUser(loginData);
    var responseData = response.data;

    if (response.statusCode == 201) {
      Auth token = Auth.fromJson(responseData["message"]);
      // save user token
      UserPreferences().saveToken = token.accessToken;

      // get user's information
      Response getUserRes = await UserApi().getUser(token);
      var getUserData = getUserRes.data;
      User authUser = User.fromJson(getUserData["message"]);
      UserPreferences().saveUser = authUser;
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
    final Map<String, String> registrationData = {
      'username': userName,
      'email': email,
      'password': password,
    };

    _registeredStatus = Status.Registering;
    notifyListeners();

    return await UserApi()
        .registerUser(registrationData)
        .then(onRegisterValue)
        .catchError(onError);
  }

  Future<Map<String, dynamic>> logout() async {
    String token = UserPreferences().getToken;
    Response logoutRes = await UserApi().logout(token);
    var logoutData = logoutRes.data;
    if (logoutRes.statusCode == 200) {
      _registeredStatus = Status.LoggedOut;
      notifyListeners();
      return {
        'status': true,
        'message': 'Successfully logged out',
        'data': logoutData["message"],
      };
    }

    return {
      'status': false,
      'message': 'Fail to log out',
    };
  }

  Future<Map<String, dynamic>> forgetPasswordStep1(String email) async {
    final Map<String, String> forgetPassStep1Email = {
      'email': email,
    };
    Response forgetPassStep1Res =
        await UserApi().forgetPasswordStep1(forgetPassStep1Email);
    var forgetPassStep1Data = forgetPassStep1Res.data;
    if (forgetPassStep1Res.statusCode == 201) {
      return {
        'status': true,
        'message': forgetPassStep1Data["message"],
      };
    }

    return {
      'status': false,
      'message': 'Fail to call forgetPasswordStep1',
    };
  }

  static Future<FutureOr> onRegisterValue(Response response) async {
    var result;
    var responseData = response.data;

    if (responseData["statusCode"] == 201) {
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': responseData["message"],
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

  static Future<FutureOr> onValue(Response response) async {
    var result;
    var responseData = response.data;

    if (responseData["statusCode"] == 201) {
      result = {
        'status': true,
        'message': responseData["message"],
        'data': responseData["data"] ? responseData["data"] : null
      };
    } else {
      result = {
        'status': false,
        'message': responseData["error"],
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is `${error.toString()}`.detail");

    return {
      'status': false,
      'message': 'Unsuccessful Request',
      'data': error.toString()
    };
  }
}
