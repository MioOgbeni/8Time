import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/service_locator.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc();

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
    var repository = injector.get<FirebaseUserRepository>();
    try {
      final isSignedIn = await repository.isSignedIn();
      if (!isSignedIn) {
        yield Unauthenticated();
      }
      final user = await repository.getUser();
      yield Authenticated(user);
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    var repository = injector.get<FirebaseUserRepository>();
    yield Authenticated(await repository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    var repository = injector.get<FirebaseUserRepository>();
    yield Unauthenticated();
    repository.signOut();
  }
}
