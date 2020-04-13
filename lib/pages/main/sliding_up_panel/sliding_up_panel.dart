import 'package:eighttime/models/activity.dart';
import 'package:eighttime/models/user.dart';
import 'package:eighttime/pages/main/sliding_up_panel/activities/activities_list.dart';
import 'package:eighttime/pages/main/sliding_up_panel/activities/activityEditForm.dart';
import 'package:eighttime/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class MySlidingUpPanel extends StatefulWidget {
  PanelController quickActivitiesController;

  MySlidingUpPanel({Key key, @required this.quickActivitiesController})
      : super(key: key);

  @override
  _MySlidingUpPanelState createState() => new _MySlidingUpPanelState();
}

class _MySlidingUpPanelState extends State<MySlidingUpPanel> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      isDraggable: false,
      controller: widget.quickActivitiesController,
      maxHeight: MediaQuery.of(context).size.height,
      minHeight: 1,
      panel: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Text(
                "Quick ",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Activities",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Material(
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActivityEditForm()),
                    );
                  },
                  child: Container(
                    width: 55,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: StreamProvider<List<Activity>>.value(
              value: DatabaseService(Provider
                  .of<User>(context)
                  .uid).activities,
              child: ActivitiesList()),
        ),
      ),
    );
  }
}
