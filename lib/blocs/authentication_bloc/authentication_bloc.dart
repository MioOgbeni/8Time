import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseActivitiesRepository firebaseActivitiesRepository;
  final FirebaseUserRepository firebaseUserRepository;
  final LocalAuthentication auth = LocalAuthentication();

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
    } else if (event is FpNeeded) {
      yield* _mapFpNeededToState();
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    bool canBiometrics;
    try {
      final isSignedIn = await firebaseUserRepository.isSignedIn();
      if (!isSignedIn) {
        yield Unauthenticated();
      }
      final user = await firebaseUserRepository.getUser();
      await firebaseActivitiesRepository.setCollectionReference();

      canBiometrics = await checkBiometrics();

      if (canBiometrics) {
        if (user.useFingerprint) {
          yield NeedFingerprint();
        } else {
          yield Authenticated(user);
        }
      } else {
        yield Authenticated(user);
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapFpNeededToState() async* {
    var canBiometrics;
    final user = await firebaseUserRepository.getUser();

    canBiometrics = await checkBiometrics();

    if (canBiometrics) {
      if (user.useFingerprint) {
        yield NeedFingerprint();
      } else {
        yield Authenticated(user);
      }
    } else {
      yield Authenticated(user);
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final user = await firebaseUserRepository.getUser();
    yield Authenticated(user);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await firebaseUserRepository.signOut();
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapUpdateUserToState(UpdateUser event) async* {
    await firebaseUserRepository.updateUser(event.user);
    final user = await firebaseUserRepository.getUser();
    yield Authenticated(user);
  }

  Future<bool> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    return canCheckBiometrics;
  }
}
