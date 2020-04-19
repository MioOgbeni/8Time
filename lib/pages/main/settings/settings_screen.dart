import 'package:cached_network_image/cached_network_image.dart';
import 'package:eighttime/blocs/authentication_bloc/bloc.dart';
import 'package:eighttime/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
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
                          imageUrl: state is Authenticated
                              ? state.user.photoUrl
                              : null,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                      strokeWidth: 5,
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Theme.of(context).errorColor,
                                size: 40,
                              ),
                              Text(
                                "Loading error",
                                style: TextStyle(
                                    color: Theme.of(context).errorColor),
                              )
                            ],
                          ),
                          imageBuilder: (context, imageProvider) => Container(
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
                      state is Authenticated ? state.user.name : null,
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
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LoggedOut());
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
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
                SwitchListTile(
                  title: Text("Use fingerprint auth"),
                  activeColor: primaryColor,
                  value: state is Authenticated
                      ? state.user.useFingerprint
                      : true,
                  subtitle: Text("Will be reseted by manual logout"),
                  onChanged: (switchState) {
                    state is Authenticated
                        ? BlocProvider.of<AuthenticationBloc>(context).add(
                        UpdateUser(
                            state.user.copyWith(useFingerprint: switchState)))
                        : null;
                  },
                  //height: 50,
                  //margin: EdgeInsets.only(bottom: 10),
                  //color: Colors.amber[500],
                  //child: const Center(child: Text('Entry B')),
                ),
              ],
            ),
          );
        });
  }
}
