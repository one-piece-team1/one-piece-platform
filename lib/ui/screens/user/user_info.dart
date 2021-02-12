import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/ui/components/common/default_scaffold.dart';

class UserInfo extends StatefulWidget {
  static const String id = 'userInfo';

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => UserInfo(),
      );

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
//    var screenSize = MediaQuery.of(context).size;
    return DefaultScaffold();
  }
}
