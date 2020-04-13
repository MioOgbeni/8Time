import 'package:eighttime/models/user.dart';
import 'package:eighttime/pages/authenticate/authenticate.dart';
import 'package:eighttime/pages/authenticate/sign_in.dart';
import 'package:eighttime/pages/main/home.dart';
import 'package:eighttime/pages/main/qr_code/qr_code_screen.dart';
import 'package:eighttime/pages/main/settings/settings_screen.dart';
import 'package:eighttime/pages/main/timeline/timeline_screen.dart';
import 'package:eighttime/pages/splash/splash_screen.dart';
import 'package:eighttime/pages/wrapper.dart';
import 'package:eighttime/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

var routes = <String, WidgetBuilder>{
  '/home': (BuildContext context) => Home(),
  '/wrapper': (BuildContext context) => Wrapper(),
  '/authenticate': (BuildContext context) => Authenticate(),
  '/signin': (BuildContext context) => SignIn(),
  '/timeline': (BuildContext context) => TimelineScreen(),
  '/qr_code': (BuildContext context) => QrCodeScreen(),
  '/settings': (BuildContext context) => SettingsScreen(),
};

const primaryColor = Color.fromRGBO(10, 154, 28, 1.0);
const errorColor = Color.fromRGBO(219, 64, 64, 1.0);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(

          theme: ThemeData(primaryColor: primaryColor,
              buttonColor: primaryColor,
              errorColor: errorColor,
              fontFamily: 'Segoe UI'),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          routes: routes),
    );
  }
}
