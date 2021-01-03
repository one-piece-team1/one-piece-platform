import 'package:flutter/material.dart';
import 'package:one_piece_platform/core/provider/auth.dart';
import 'package:one_piece_platform/core/provider/user_provider.dart';
import 'package:one_piece_platform/ui/screens/authentication/login_screen.dart';
import 'package:one_piece_platform/ui/screens/authentication/registration_screen.dart';
import 'package:one_piece_platform/ui/screens/dashboard.dart';
import 'package:one_piece_platform/ui/screens/welcome.dart';
import 'package:provider/provider.dart';

import 'core/models/user_model.dart';
import 'core/util/shared_preference.dart';

Future<void> main() async {
  // init shared preferences for getter and setter
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(OnePiecePlatform());
}

class OnePiecePlatform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Ahoy!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else if (snapshot.data.id == null)
                    return LoginScreen();
                  else if (snapshot.data.id != null)
                    return DashBoard();
                  else
                    UserPreferences().removeUser();
                  return Welcome(user: snapshot.data);
              }
            }),
        initialRoute: RegistrationScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          DashBoard.id: (context) => DashBoard(),
        },
      ),
    );
  }
}
