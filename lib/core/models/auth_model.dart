import 'package:flutter/foundation.dart';

class Auth {
  String accessToken;

  Auth({
    @required this.accessToken,
  });

  factory Auth.fromJson(Map<String, dynamic> responseData) {
    return Auth(
      accessToken: responseData['accessToken'],
    );
  }
}
