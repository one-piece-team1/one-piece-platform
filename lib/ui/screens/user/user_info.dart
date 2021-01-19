import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:one_piece_platform/ui/components/common/default_scaffold.dart';

class UserInfo extends StatefulWidget {
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
//    return Scaffold(
//      backgroundColor: Colors.white,
//      extendBodyBehindAppBar: true,
//      body: ModalProgressHUD(
//        inAsyncCall: showSpinner,
//        child: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: Stack(
//            children: <Widget>[
//              Container(
//                height: screenSize.height * 0.2,
//                color: Colors.grey[600],
//              ),
//              Padding(
//                padding: EdgeInsets.symmetric(
//                  horizontal: screenSize.height * 0.06,
//                ),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    SizedBox(
//                      height: screenSize.height * 0.15,
//                    ),
//                    ClipRRect(
//                      borderRadius: BorderRadius.circular(20),
//                      child: Container(
//                        height: screenSize.height * 0.1,
//                        child: Image.asset('images/logo.png'),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              new Positioned(
//                top: 0.0,
//                left: 0.0,
//                right: 0.0,
//                child: AppBar(
//                  title: Text(''), // You can add title here
//                  leading: new IconButton(
//                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
//                    onPressed: () => Navigator.of(context).pop(),
//                  ),
//                  backgroundColor:
//                      Colors.grey[800], //You can make this transparent
//                  elevation: 0.0, //No shadow
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
  }
}
