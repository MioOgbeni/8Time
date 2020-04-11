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
        body: Container(
          color: Colors.white,
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
