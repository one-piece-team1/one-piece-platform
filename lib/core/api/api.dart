import 'package:dio/dio.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';
import 'package:one_piece_platform/core/api/app_config.dart';

class BaseApi {
  static const String userService = 'one-piece-user';
  static String baseURL;

// set app environment as dev
  void _initialize() {
    setEnvironment(Environment.dev);
    baseURL = apiBaseUrl;
  }

  Dio dioWithoutToken(String serviceName) {
    _initialize();
    print('baseURL $baseURL');
    final BaseOptions baseOptions = new BaseOptions(
        baseUrl: baseURL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          "service-name": serviceName,
        });
    return Dio(baseOptions);
  }

  Dio dioWithToken(String serviceName) {
    String accessToken = UserPreferences().getToken;

    final BaseOptions baseOptions = new BaseOptions(
        baseUrl: baseURL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {"service-name": serviceName, "Authorization": accessToken});

    return Dio(baseOptions);
  }

// USER

  static final String userBaseURL = baseURL + "/users";

  static final String getUserInfo = userBaseURL + "/info";

  static final String loginWithGoogle = userBaseURL + "google";
  static final String loginWithFacebook = userBaseURL + "";
  static final String logout = userBaseURL + "/logout";
  static final String forgetPwdStep1 = userBaseURL + "/forgets/generates";
  static final String forgetPwdStep2 = userBaseURL + "/forgets/verifies";
  static final String forgetPwdStep3 = userBaseURL + "/forgets/confirms";
  static final String getUserPaging = userBaseURL + "/paging";
  static final String signUp = userBaseURL + "/signup";
  static final String signIn = userBaseURL + "/signin";

  //TODO: find out the dynamic link, pass id down in function and convert to a String
  static final String login = userBaseURL + "/{id}/password";
}
