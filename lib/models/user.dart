class User {
  String userId;
  String username;
  String email;
  String licence;
  String role;

  String token;
  String refreshToken;

  //TODO: follow up to write the login function\
  //https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d
  User(
      {this.email,
      this.username,
      this.token,
      this.refreshToken,
      this.userId,
      this.licence,
      this.role});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['user']['id'],
        username: responseData['user']['username'],
        email: responseData['user']['email'],
        licence: responseData['user']['licence'],
        role: responseData['user']['role'],
        token: responseData['user']['token'],
        refreshToken: responseData['user']['refreshToken']);
  }
}
