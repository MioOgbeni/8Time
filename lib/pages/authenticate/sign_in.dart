import 'package:eighttime/models/user.dart';
import 'package:eighttime/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
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
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Please create account with",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15),),
                  SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)
                    ),
                    text: "Sign up with Google",
                    onPressed: () async {
                      User result = await _auth.signInGoogle();
                      if (result == null) {
                        print('error signing in');
                      } else {
                        print('signed in');
                        print(result.uid);
                        print(result.photoUrl);
                      }
                    },
                  ),
                  Text(
                    "or",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                  Text(
                    "TODO Facebook_Auth",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
