class AppUrl {
  static const String localBaseURL = "http://localhost:8081/v1/api";
  static const String liveBaseURL = "http://localhost:8081/v1/api";

// USER
//  Retrofit implementation in Flutter:  https://medium.com/globant/easy-way-to-implement-rest-api-calls-in-flutter-9859d1ab5396
  static const String baseURL = localBaseURL;
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
