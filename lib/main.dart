import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/pages/login/login_screen.dart';
import 'package:eighttime/pages/main/home.dart';
import 'package:eighttime/pages/main/qr_code/qr_code_screen.dart';
import 'package:eighttime/pages/main/settings/settings_screen.dart';
import 'package:eighttime/pages/main/timeline/timeline_screen.dart';
import 'package:eighttime/pages/splash/splash_screen.dart';
import 'package:eighttime/simple_bloc_delegate.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
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
  final FirebaseUserRepository firebaseUserRepository =
  FirebaseUserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
      AuthenticationBloc(firebaseUserRepository: firebaseUserRepository)
        ..add(AppStarted()),
      child: App(firebaseUserRepository: firebaseUserRepository),
    ),
  );
}

class App extends StatelessWidget {
  final FirebaseUserRepository _firebaseUserRepository;

  App({Key key, @required FirebaseUserRepository firebaseUserRepository})
      : assert(firebaseUserRepository != null),
        _firebaseUserRepository = firebaseUserRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                firebaseUserRepository: FirebaseUserRepository(),
              )
                ..add(AppStarted());
            },
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
                return LoginScreen(
                    firebaseUserRepository: _firebaseUserRepository);
              }
              if (state is Authenticated) {
                return BlocProvider<ActivitiesBloc>(
                    child: Home(),
                    create: (context) {
                      return ActivitiesBloc(
                        activitiesRepository: FirebaseActivitiesRepository(
                            userUid: state.user.uid),
                      )
                        ..add(LoadActivities());
                    });
              }
            },
          ),
        ));
  }
}
