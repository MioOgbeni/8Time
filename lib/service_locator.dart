import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/blocs/fingerprint_bloc/bloc.dart';
import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:eighttime/blocs/splash_screen_bloc/bloc.dart';
import 'package:eighttime/blocs/work_events_bloc/bloc.dart';
import 'package:eighttime/src/models/activity/firebase_activities_repository.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:eighttime/src/models/work_event/firebase_work_event_repository.dart';
import 'package:eighttime/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'activities_repository.dart';

GetIt injector = GetIt.instance;

void setupLocator() {
  injector.registerFactory<AuthenticationBloc>(() => (AuthenticationBloc(
      firebaseUserRepository: injector(),
      firebaseActivitiesRepository: injector())));

  injector.registerFactory<SplashScreenBloc>(() => SplashScreenBloc());
  injector.registerFactory<LoginBloc>(
      () => LoginBloc(firebaseUserRepository: injector()));
  injector.registerFactory<ActivitiesBloc>(
          () =>
          ActivitiesBloc(firebaseActivitiesRepository: injector(),
              firebaseWorkEventRepository: injector()));
  injector.registerFactory<WorkEventsBloc>(
          () =>
          WorkEventsBloc(firebaseWorkEventRepository: injector(),
              firebaseActivitiesRepository: injector()));
  injector.registerFactory<FingerprintBloc>(() => FingerprintBloc());

  injector.registerLazySingleton<FirebaseUserRepository>(
      () => FirebaseUserRepository());
  injector.registerLazySingleton<FirebaseActivitiesRepository>(
      () => FirebaseActivitiesRepository());
  injector.registerLazySingleton<FirebaseWorkEventRepository>(
          () => FirebaseWorkEventRepository());
}
