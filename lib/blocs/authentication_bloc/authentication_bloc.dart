import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseUserRepository _firebaseUserRepository;

  AuthenticationBloc({@required FirebaseUserRepository firebaseUserRepository})
      : assert(firebaseUserRepository != null),
        _firebaseUserRepository = firebaseUserRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _firebaseUserRepository.isSignedIn();
      if (!isSignedIn) {
        await _firebaseUserRepository.signInWithGoogle();
      }
      final user = await _firebaseUserRepository.getUser();
      yield Authenticated(user);
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _firebaseUserRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _firebaseUserRepository.signOut();
  }
}
