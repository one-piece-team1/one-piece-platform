import 'dart:async';

import 'package:dio/dio.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/models/auth_model.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';

final accessToken = UserPreferences().getToken;

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
    Response response =
        await dioWithToken(BaseApi.userService).get(BaseApi.getUserInfo);
    return response;
  }

  Future<Response> forgetPasswordStep1(Map<String, String> data) async {
    Response response = await dioWithoutToken(BaseApi.userService)
        .post(BaseApi.forgetPwdStep1, data: data);
    return response;
  }

  Future<Response> forgetPasswordStep2(Map<String, String> data) async {
    Response response = await dioWithoutToken(BaseApi.userService)
        .post(BaseApi.forgetPwdStep2, data: data);
    return response;
  }

  Future<Response> forgetPasswordStep3(Map<String, String> data) async {
    Response response = await dioWithoutToken(BaseApi.userService)
        .post(BaseApi.forgetPwdStep3, data: data);
    return response;
  }

  Future<Response> logout(String token) async {
    Response response =
        await dioWithToken(BaseApi.userService).get(BaseApi.logout);
    return response;
  }
}
