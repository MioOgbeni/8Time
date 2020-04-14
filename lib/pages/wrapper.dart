import 'package:eighttime/models/user.dart';
import 'package:eighttime/pages/authenticate/authenticate.dart';
import 'package:eighttime/pages/main/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with WidgetsBindingObserver {
  var _auth = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<bool> _authenticateUser() async {
    try {
      return isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason:
        "Please authenticate yourself",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      print('*****************');
      print('App resumed');
      print('*****************');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Wrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return FutureBuilder<bool>(
          future: _isBiometricAvailable(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              // while data is loading:
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme
                                .of(context)
                                .primaryColor),
                        strokeWidth: 5),
                  )
              );
            } else {
              // data loaded:
              final _isBiometricAvailable = snapshot.data;

              if (_isBiometricAvailable) {
                return FutureBuilder<bool>(
                    future: _authenticateUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        // while data is loading:
                        return Scaffold(
                            backgroundColor: Colors.white,
                            body: Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme
                                          .of(context)
                                          .primaryColor),
                                  strokeWidth: 5),
                            )
                        );
                      } else {
                        // data loaded:
                        final _authenticateUser = snapshot.data;

                        if (!_authenticateUser) {
                          return Wrapper();
                        } else {
                          return Home();
                        }
                      }
                    });
              } else {
                return Home();
              }
            }
          });
    }
  }
}
