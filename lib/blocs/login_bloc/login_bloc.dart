import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:eighttime/service_locator.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc();

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await injector.get<FirebaseUserRepository>().signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      print(e);
      yield LoginState.failure();
    }
  }
}
