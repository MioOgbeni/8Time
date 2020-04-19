import 'package:eighttime/blocs/fingerprint_bloc/bloc.dart';
import 'package:eighttime/pages/fingerprint/fingerprint_form.dart';
import 'package:eighttime/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FingerprintScreen extends StatelessWidget {
  FingerprintScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<FingerprintBloc>(
        create: (context) => injector<FingerprintBloc>(),
        child: FingerprintForm(),
      ),
    );
  }
}
