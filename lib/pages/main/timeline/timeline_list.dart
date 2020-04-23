import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/work_events_bloc/bloc.dart';
import 'package:eighttime/pages/main/timeline/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineList extends StatefulWidget {
  List<WorkEvent> workEvents;

  TimelineList({Key key, @required this.workEvents}) : super(key: key);

  @override
  _TimelineListState createState() => _TimelineListState();
}

class _TimelineListState extends State<TimelineList> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.workEvents != null) {
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
      return Container();
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
            BlocProvider.of<WorkEventsBloc>(context)
                .add(DeleteWorkEvent(workEvent));
          },
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text("00:00"),
                    width: 35),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center, child: Text("-"), width: 35),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text("88:88"),
                    width: 35),
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
              workEvent.description,
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
                      "8:00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    width: 35),
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
