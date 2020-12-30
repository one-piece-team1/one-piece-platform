import 'package:dio/dio.dart';
import 'package:one_piece_platform/core/api/api.dart';
import 'package:one_piece_platform/core/models/user_model.dart';

class UserApi extends BaseApi {
  Future<Response> registerUser(Map<String, String> data) async {
    Response response =
        await dio.post(BaseApi.userBaseURL + '/signin', data: data);
    return response;
  }

  Future<Response> logInUser(Map<String, dynamic> data) async {
    Response response =
        await dio.post(BaseApi.userBaseURL + '/signin', data: data);
    return response;
  }
}
