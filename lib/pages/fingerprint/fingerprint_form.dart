import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/blocs/fingerprint_bloc/bloc.dart';
import 'package:eighttime/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FingerprintForm extends StatefulWidget {
  FingerprintForm({Key key}) : super(key: key);

  State<FingerprintForm> createState() => _FingerprintFormState();
}

class _FingerprintFormState extends State<FingerprintForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FingerprintBloc, FingerprintState>(
        listener: (context, state) {
      if (state is FpUnauthenticated) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Failed. Try Again!'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
      if (state is FpAuthenticated) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<FingerprintBloc, FingerprintState>(
      builder: (context, state) {
        return InkWell(
            onTap: () {
              BlocProvider.of<FingerprintBloc>(context).add(
                FpApproved(),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.fingerprint,
                              color: Theme.of(context).primaryColor,
                              size: 100.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Click to authenticate",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          Text(
                            "After clicking, you will be prompted to scan.",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ));
      },
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
