import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseActivitiesRepository firebaseActivitiesRepository;
  final FirebaseUserRepository firebaseUserRepository;

  AuthenticationBloc(
      {@required this.firebaseActivitiesRepository,
      @required this.firebaseUserRepository});

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
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await firebaseUserRepository.isSignedIn();
      if (!isSignedIn) {
        yield Unauthenticated();
      }
      final user = await firebaseUserRepository.getUser(
          await firebaseUserRepository.getUserId());
      await firebaseActivitiesRepository.setCollectionReference();

      yield Authenticated(user);
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final user = await firebaseUserRepository.getUser(
        await firebaseUserRepository.getUserId());
    yield Authenticated(user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await firebaseUserRepository.signOut();
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapUpdateUserToState(UpdateUser event) async* {
    await firebaseUserRepository.updateUser(event.user);
    final user = await firebaseUserRepository.getUser(
        await firebaseUserRepository.getUserId());
    yield Authenticated(user);
  }
}
