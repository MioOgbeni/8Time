import 'package:eighttime/services/activities_service.dart';
import 'package:eighttime/services/authenticate_service.dart';
import 'package:eighttime/services/firebase_activities_repository_service.dart';
import 'package:eighttime/services/firebase_user_repository_service.dart';
import 'package:eighttime/services/login_service.dart';
import 'package:eighttime/services/splash_screen_service.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

void setupLocator() {
  injector.registerSingleton(AuthenticationService());
  injector.registerSingleton(SplashScreenService());
  injector.registerSingleton(LoginService());
  injector.registerSingleton(ActivitiesService());

  injector.registerFactory<FirebaseUserRepositoryService>(
      () => FirebaseUserRepositoryService());
  injector.registerFactory<FirebaseActivitiesRepositoryService>(
      () => FirebaseActivitiesRepositoryService());
}
