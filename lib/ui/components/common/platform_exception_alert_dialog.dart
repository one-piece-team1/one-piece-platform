import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:one_piece_platform/ui/components/common/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'The password is weak',
    'ERROR_INVALID_EMAIL': 'The email is invalid',
    'ERROR_EMAIL_ALREADY_IN_USE': 'The email is already in use',
    'ERROR_WRONG_PASSWORD': 'The password is invalid',
    'ERROR_USER_NOT_FOUND': 'The user is not found',
    'ERROR_USER_DISABLED': 'The user has been disabled',
    'ERROR_TOO_MANY_REQUESTS': 'Too many attempts to sign in as this user',
    'ERROR_OPERATION_NOT_ALLOWED': 'Email & Password accounts are not enabled',
  };
}
