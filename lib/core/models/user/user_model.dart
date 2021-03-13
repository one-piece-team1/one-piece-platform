class User {
  String id;
  String username;
  String email;
  String licence;
  String role;

  //TODO: follow up to write the login function
  //https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d
  User({
    this.email,
    this.username,
    this.id,
    this.licence = '',
    this.role = '',
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson['user']['id'],
        username: parsedJson['user']['username'],
        email: parsedJson['user']['email'],
        licence: parsedJson['user']['licence'],
        role: parsedJson['user']['role']);
  }
}
