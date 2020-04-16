import 'package:eighttime/blocs/splash_screen_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void didChangeDependencies() {
    this._dispatchEvent(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(decoration: BoxDecoration(color: Colors.white)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.hourglass_empty,
                      color: Theme.of(context).primaryColor,
                      size: 100.0,
                    ),
                    Text(
                      "8Time",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                      strokeWidth: 3.0,
                    ),
                    height: 20.0,
                    width: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  Text(
                    "Loading...",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }

  void _dispatchEvent(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(
      NavigateToHomeScreenEvent(),
    );
  }
}
