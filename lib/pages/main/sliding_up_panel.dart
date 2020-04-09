import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      controller: widget.quickActivitiesController,
      maxHeight: MediaQuery.of(context).size.height,
      minHeight: 0,
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
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("QuickActivities")],
          ),
        ),
      ),
    );
  }
}
