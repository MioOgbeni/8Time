import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseUserRepository _firebaseUserRepository;

  LoginBloc({
    @required FirebaseUserRepository firebaseUserRepository,
  })  : assert(firebaseUserRepository != null),
        _firebaseUserRepository = firebaseUserRepository;

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
      await _firebaseUserRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      print(e);
      yield LoginState.failure();
    }
  }
}
