import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/fingerprint_bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintBloc extends Bloc<FingerprintEvent, FingerprintState> {
  LocalAuthentication auth;

  FingerprintBloc() {
    auth = LocalAuthentication();
  }

  @override
  FingerprintState get initialState => FpUnauthenticated();

  @override
  Stream<FingerprintState> mapEventToState(FingerprintEvent event) async* {
    if (event is FpInitialized) {
      yield* _mapUnauthenticatedToState();
    } else if (event is FpApproved) {
      yield* _mapAuthenticatedToState();
    }
  }

  Stream<FingerprintState> _mapUnauthenticatedToState() async* {
    yield FpUnauthenticated();
  }

  Stream<FingerprintState> _mapAuthenticatedToState() async* {
    bool authenticated = false;
    authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: true);

    if (authenticated) {
      yield FpAuthenticated();
    } else {
      yield FpUnauthenticated();
    }
  }
}
