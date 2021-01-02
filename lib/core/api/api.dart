import 'package:dio/dio.dart';
import 'package:one_piece_platform/core/models/auth_model.dart';
import 'package:one_piece_platform/core/util/shared_preference.dart';

class BaseApi {
//  Dio dio = Dio(options);
  static const String localBaseURL = "http://localhost:8081/v1/api";
  static const String liveBaseURL = "http://localhost:8081/v1/api";
  static const String baseURL = localBaseURL;
  static const String userService = 'one-piece-user';

//  static BaseOptions options = BaseOptions(
//      baseUrl: baseURL,
//      connectTimeout: 5000,
//      receiveTimeout: 3000,
//      contentType: 'JSON',
//      headers: {
//        "service-name": "one-piece-user",
//      });

  Dio dioWithoutToken(String serviceName) {
    final BaseOptions baseOptions = new BaseOptions(
        baseUrl: baseURL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: 'JSON',
        headers: {
          "service-name": serviceName,
        });

    return Dio(baseOptions);
  }

  Dio dioWithToken(String serviceName) {
    Future<Auth> accessToken = UserPreferences().getToken();

    final BaseOptions baseOptions = new BaseOptions(
        baseUrl: baseURL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        contentType: 'JSON',
        headers: {"service-name": serviceName, "Token": accessToken});

    return Dio(baseOptions);
  }

// USER
  // References:
  // Retrofit implementation in Flutter:  https://medium.com/globant/easy-way-to-implement-rest-api-calls-in-flutter-9859d1ab5396
  // dio implementation: https://medium.com/@ashmikattel/dio-in-flutter-ad6ba26aee36
  // TODO: http with Provider(prefer this one): https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d
  // TODO: dio with Provider: https://github.com/SquashConsulting/flutter_provider_boilerplate

  static const String userBaseURL = baseURL + "/users";

  static const String getUserInfo = userBaseURL + "/info";
  static const String loginWithGoogle = userBaseURL + "";
  static const String loginWithFacebook = userBaseURL + "";
  static const String logout = userBaseURL + "/logout";
  static const String forgetPwdStep1 = userBaseURL + "/forgets/generates";
  static const String forgetPwdStep2 = userBaseURL + "/forgets/verifies";
  static const String forgetPwdStep3 = userBaseURL + "/forgets/confirms";
  static const String getUserPaging = userBaseURL + "/paging";
  static const String signUp = userBaseURL + "/signup";
  static const String signIn = userBaseURL + "/signin";

  //TODO: find out the dynamic link, pass id down in function and convert to a String
  static const String login = userBaseURL + "/{id}/password";
}
