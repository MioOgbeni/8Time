import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/splash_screen_bloc/bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  @override
  SplashScreenState get initialState => Initial();

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is NavigateToHomeScreenEvent) {
      yield Loading();

      // During the Loading state we can do additional checks like,
      // if the internet connection is available or not etc..

      await Future.delayed(Duration(
          seconds: 4)); // This is to simulate that above checking process
      yield Loaded(); // In this state we can load the HOME PAGE
    }
  }
}
