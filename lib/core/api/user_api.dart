import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/models/auth_model.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';

final accessToken = UserPreferences().getToken();

class UserApi extends BaseApi {
  Future<Response> registerUser(Map<String, dynamic> data) async {
    Response response = await dioWithoutToken(BaseApi.userService)
        .post(BaseApi.userBaseURL + '/signup', data: data);
    return response;
  }

  Future<Response> logInUser(Map<String, dynamic> data) async {
    Response response = await dioWithoutToken(BaseApi.userService)
        .post(BaseApi.userBaseURL + '/signin', data: data);

    return response;
  }

  Future<Response> getUser(Auth token) async {
    Response response = await dioWithToken(BaseApi.userService)
        .get(BaseApi.userBaseURL + '/info');
    return response;
  }
}
