import 'dart:async';

import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/main.dart';
import 'package:eighttime/pages/main/timeline/timeline.dart';
import 'package:eighttime/pages/main/timeline/workEventEditForm.dart';
import 'package:eighttime/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiver/async.dart';

class TimelineList extends StatefulWidget {
  List<WorkEvent> workEvents;

  TimelineList({Key key, @required this.workEvents}) : super(key: key);

  @override
  _TimelineListState createState() => _TimelineListState();
}

class _TimelineListState extends State<TimelineList> {
  ScrollController _scrollController = ScrollController();
  StreamSubscription metronomeListen;

  @override
  void initState() {
    metronomeListen =
        Metronome.epoch(Duration(minutes: 1)).listen((d) =>
            setState(() {
              print(DateTime.now());
            }));
    super.initState();
  }

  @override
  void dispose() {
    metronomeListen.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.workEvents != null && widget.workEvents.isNotEmpty) {
      return Timeline(
          controller: _scrollController,
          children: getTileWidgets(widget.workEvents),
          lineColor: Colors.black12,
          strokeWidth: 4,
          strokeCap: StrokeCap.round,
          primary: false,
          indicatorSize: 35,
          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
          indicators: getIndicatorWidgets(widget.workEvents));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.event_busy,
                    color: Colors.black.withOpacity(0.09),
                    size: 100.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "This day is empty",
                  style: TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Text(
                  "Create work for this day by Quick Activities",
                  style: TextStyle(
                      color: Colors.black12,
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
      );
    }
  }

  List<Widget> getIndicatorWidgets(List<WorkEvent> workEvents) {
    List<Widget> list = new List<Widget>();
    for (final workEvent in workEvents) {
      list.add(Icon(Activity.enumToIcon(workEvent.activity.icon),
          size: 22, color: Activity.enumToColor(workEvent.activity.color)));
    }
    return list;
  }

  List<Widget> getTileWidgets(List<WorkEvent> workEvents) {
    List<Widget> list = new List<Widget>();
    for (final workEvent in workEvents) {
      list.add(Card(
        elevation: 2,
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WorkEventEditForm(editWorkEvent: workEvent)));
            /*
            BlocProvider.of<WorkEventsBloc>(context)
                .add(DeleteWorkEvent(workEvent));
                
             */
          },
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(DateUtil.getTimeFromDateTime(
                        DateUtil.getDateTimeFromTimestamp(workEvent.fromTime))),
                    width: 37),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center, child: Text("-"), width: 37),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: workEvent.toTime != null
                        ? Text(DateUtil.getTimeFromDateTime(
                        DateUtil.getDateTimeFromTimestamp(
                            workEvent.toTime)))
                        : SpinKitThreeBounce(
                      color: primaryColor,
                      size: 15,
                    ),
                    width: 37),
              ),
            ],
          ),
          title: Container(
            width: double.infinity,
            child: Text(
              workEvent.activity.name,
              textWidthBasis: TextWidthBasis.longestLine,
              overflow: TextOverflow.ellipsis,
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          subtitle: Container(
            width: double.infinity,
            child: Text(
              workEvent.geoPoint != null ? workEvent.address : "",
              textWidthBasis: TextWidthBasis.longestLine,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      workEvent.toTime != null
                          ? DateUtil.getDifferenceBetweenTwoTimes(
                          DateUtil.getDateTimeFromTimestamp(
                              workEvent.fromTime),
                          DateUtil.getDateTimeFromTimestamp(
                              workEvent.toTime))
                          : DateUtil.getDifferenceBetweenTwoTimes(
                          DateUtil.getDateTimeFromTimestamp(
                              workEvent.fromTime),
                          DateUtil.now()),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    width: 37),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.only(left: 10),
      ));
    }
    return list;
  }
}
