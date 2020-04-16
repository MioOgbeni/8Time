import 'package:eighttime/blocs/login_bloc/bloc.dart';
import 'package:eighttime/pages/login/login_form.dart';
import 'package:eighttime/src/models/user/firebase_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseUserRepository _firebaseUserRepository;

  LoginScreen(
      {Key key, @required FirebaseUserRepository firebaseUserRepository})
      : assert(firebaseUserRepository != null),
        _firebaseUserRepository = firebaseUserRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(firebaseUserRepository: _firebaseUserRepository),
        child: LoginForm(),
      ),
    );
  }
}
