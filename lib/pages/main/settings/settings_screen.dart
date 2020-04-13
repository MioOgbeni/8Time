import 'package:cached_network_image/cached_network_image.dart';
import 'package:eighttime/models/user.dart';
import 'package:eighttime/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        shrinkWrap: false,
        children: <Widget>[
          Container(
            height: 230,
            child: Card(
              color: Colors.white,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 110.0,
                      height: 110.0,
                      child: CachedNetworkImage(
                        imageUrl: Provider
                            .of<User>(context)
                            .photoUrl,
                        progressIndicatorBuilder: (context, url,
                            downloadProgress) =>
                            CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Theme
                                        .of(context)
                                        .primaryColor),
                                strokeWidth: 5,
                                value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.error_outline,
                                  color: Theme
                                      .of(context)
                                      .errorColor,
                                  size: 40,
                                ),
                                Text(
                                  "Loading error",
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .errorColor),
                                )
                              ],
                            ),
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Text(
                    Provider
                        .of<User>(context)
                        .name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  SizedBox(
                    height: 32,
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
        ],
      ),
    );
  }
}
