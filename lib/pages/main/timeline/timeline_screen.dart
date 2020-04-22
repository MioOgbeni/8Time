import 'dart:math';

import 'package:eighttime/main.dart';
import 'package:eighttime/pages/main/timeline/timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimelineScreen extends StatefulWidget {
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreenState createState() => new _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  void goToToday() {
    print("goToToday");
    setState(() {
      _calendarController.setSelectedDay(DateTime.now(), animate: true);
    });
  }

  void someDaySelected(DateTime date) {
    print("selected date: $date");
    setState(() {
      _calendarController.setSelectedDay(date, animate: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 17),
            ),
            TableCalendar(
              calendarController: _calendarController,
              initialCalendarFormat: CalendarFormat.week,
              headerVisible: false,
              availableGestures: AvailableGestures.horizontalSwipe,
              onDayLongPressed: (date, events) {
                goToToday();
              },
              onDaySelected: (date, events) {
                someDaySelected(date);
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle().copyWith(color: Colors.black),
                weekendStyle: TextStyle().copyWith(color: primaryColor),
              ),
              builders: CalendarBuilders(
                todayDayBuilder: (context, date, events) =>
                    Container(
                      height: 5,
                      margin: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                selectedDayBuilder: (context, date, events) =>
                    Container(
                      height: 5,
                      margin: EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              ),
              calendarStyle: CalendarStyle(
                  weekdayStyle: TextStyle().copyWith(color: Colors.black),
                  weekendStyle: TextStyle().copyWith(color: primaryColor),
                  outsideDaysVisible: true,
                  outsideStyle: TextStyle().copyWith(color: Colors.black26),
                  outsideWeekendStyle: TextStyle()
                      .copyWith(color: primaryColor.withOpacity(0.26))),
            ),
            Expanded(
              child: Timeline(
                  children: getTileWidgets(10),
                  lineColor: Colors.black12,
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  primary: true,
                  indicatorSize: 35,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  indicators: getIndicatorWidgets(10)
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getIndicatorWidgets(int length) {
    final List<IconData> iconData = <IconData>[
      Icons.play_arrow,
      Icons.stop,
      Icons.pause,
      Icons.work,
      Icons.memory,
      Icons.exit_to_app,
      Icons.directions_car,
      Icons.free_breakfast,
      Icons.developer_mode
    ];
    final List<Color> colorData = <Color>[
      errorColor,
      primaryColor,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple
    ];
    final Random r = Random();

    List<Widget> list = new List<Widget>();
    for (var i = 0; i < length; i++) {
      list.add(Icon(iconData[r.nextInt(iconData.length)], size: 22,
          color: colorData[r.nextInt(colorData.length)]));
    }
    return list;
  }

  List<Widget> getTileWidgets(int length) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < length; i++) {
      list.add(Card(
        elevation: 2,
        color: Colors.white,
        child: Container(
          height: 100,
          width: double.infinity,
          child: Text("Testing card"),
        ),
        margin: EdgeInsets.only(left: 10),
      ));
    }
    return list;
  }
}
