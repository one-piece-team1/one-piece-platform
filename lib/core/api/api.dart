import 'package:dio/dio.dart';

class BaseApi {
  Dio dio = Dio(options);
  static const String localBaseURL = "http://localhost:8081/v1/api";
  static const String liveBaseURL = "http://localhost:8081/v1/api";
  static const String baseURL = localBaseURL;

  static BaseOptions options = BaseOptions(
    baseUrl: baseURL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

// USER
  // References:
  // Retrofit implementation in Flutter:  https://medium.com/globant/easy-way-to-implement-rest-api-calls-in-flutter-9859d1ab5396
  // dio implementation: https://medium.com/@ashmikattel/dio-in-flutter-ad6ba26aee36
  // TODO: http with Provider: https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d
  // TODO: dio with Provider(prefer this one): https://github.com/SquashConsulting/flutter_provider_boilerplate

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

  //TODO: find out the dynamic link
  static const String login = userBaseURL + "/{id}/password";
}
