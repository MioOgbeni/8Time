import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
      text: "Sign up with Google",
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
    );
  }
}
