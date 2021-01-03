import 'package:flutter/foundation.dart';

class Auth {
  String accessToken;

  Auth({
    @required this.accessToken,
  });

  factory Auth.fromJson(String accessToken) {
    return Auth(
      accessToken: accessToken,
    );
  }
}
