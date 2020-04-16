import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/pages/login/login_screen.dart';
import 'package:eighttime/pages/main/home.dart';
import 'package:eighttime/pages/main/qr_code/qr_code_screen.dart';
import 'package:eighttime/pages/main/settings/settings_screen.dart';
import 'package:eighttime/pages/main/timeline/timeline_screen.dart';
import 'package:eighttime/pages/splash/splash_screen.dart';
import 'package:eighttime/service_locator.dart';
import 'package:eighttime/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var routes = <String, WidgetBuilder>{
  '/home': (BuildContext context) => Home(),
  '/timeline': (BuildContext context) => TimelineScreen(),
  '/qr_code': (BuildContext context) => QrCodeScreen(),
  '/settings': (BuildContext context) => SettingsScreen(),
};

const primaryColor = Color.fromRGBO(10, 154, 28, 1.0);
const errorColor = Color.fromRGBO(219, 64, 64, 1.0);
bool isAuthenticated = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setupLocator();
  runApp(
    BlocProvider(
      create: (context) =>
      injector<AuthenticationBloc>()
        ..add(AppStarted()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            injector<AuthenticationBloc>()
              ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) =>
            injector<ActivitiesBloc>()
              ..add(LoadActivities()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: primaryColor,
              buttonColor: primaryColor,
              errorColor: errorColor,
              fontFamily: 'Segoe UI'),
          debugShowCheckedModeBanner: false,
          routes: routes,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is Uninitialized) {
                return SplashScreen();
              }
              if (state is Unauthenticated) {
                return LoginScreen();
              }
              if (state is Authenticated) {
                return Home();
              }
            },
          ),
        ));
  }
}
