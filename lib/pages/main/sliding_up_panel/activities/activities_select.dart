import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:eighttime/pages/main/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ActivitiesSelect extends StatefulWidget {
  ActivitiesSelect({Key key}) : super(key: key);

  @override
  _ActivitiesSelectState createState() => new _ActivitiesSelectState();
}

class _ActivitiesSelectState extends State<ActivitiesSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text(
              "Select ",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Activity",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        child: BlocBuilder<ActivitiesBloc, ActivitiesState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is ActivitiesLoading) {
              return LoadingIndicator();
            }
            if (state is ActivitiesLoaded) {
              return ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  for (final item in state.activities)
                    Card(
                      key: ValueKey(item),
                      child: ListTile(
                        key: ValueKey(item),
                        onTap: () {
                          Navigator.pop(context, item);
                        },
                        enabled: true,
                        contentPadding: EdgeInsets.only(left: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.black12))),
                          child: Icon(
                            Activity.enumToIcon(item.icon),
                            color: Activity.enumToColor(item.color),
                            size: 35,
                          ),
                        ),
                        title: Container(
                          width: double.infinity,
                          child: Text(
                            item.name,
                            textWidthBasis: TextWidthBasis.longestLine,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
