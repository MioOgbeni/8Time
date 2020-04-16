import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:eighttime/blocs/splash_screen_bloc/bloc.dart';
import 'package:eighttime/src/models/activity/firebase_activities_repository.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

void setupLocator() {
  injector.registerSingleton<AuthenticationBloc>(AuthenticationBloc());
  injector.registerSingleton<SplashScreenBloc>(SplashScreenBloc());
  injector.registerSingleton<LoginBloc>(LoginBloc());
  injector.registerSingleton<ActivitiesBloc>(ActivitiesBloc());

  injector.registerSingleton<FirebaseUserRepository>(FirebaseUserRepository());
  injector.registerLazySingleton<FirebaseActivitiesRepository>(() =>
      FirebaseActivitiesRepository());
}
