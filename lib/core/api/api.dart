import 'dart:async';

import 'package:dio/dio.dart';
import 'package:one_piece_platform/core/api/app_config.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseApi {
  static const String userService = 'one-piece-user';
  static String baseURL;
  static String oAuthBaseURL;

// set app environment as dev
  void _initializeBaseApi() {
    setEnvironment(Environment.dev);
    baseURL = apiBaseUrl;
    oAuthBaseURL = apiOAuthBaseUrl;
  }

  Future<void> launchOAuthURL(String oAuthType) async {
    String _url;
    switch (oAuthType) {
      case 'google':
        _initializeBaseApi();
        _url = loginWithGoogle;
        break;
      case 'facebook':
        _initializeBaseApi();

        _url = loginWithFacebook;
        break;
      default:
        _url = loginWithGoogle;
    }
    print('_url $_url');

    await _launch(_url);
  }

  Future _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'service-name': userService},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Dio dioWithoutToken(String serviceName) {
    _initializeBaseApi();

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
    _initializeBaseApi();

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

  static final String loginWithGoogle = oAuthBaseURL + "/google";
  static final String loginWithFacebook = oAuthBaseURL + "/facebook";
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
