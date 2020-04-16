import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:eighttime/pages/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}
