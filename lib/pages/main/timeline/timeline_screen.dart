import 'package:eighttime/main.dart';
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
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text(
              "Daily ",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Timeline",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TableCalendar(

              calendarController: _calendarController,
              initialCalendarFormat: CalendarFormat.week,
              headerVisible: false,
              formatAnimation: FormatAnimation.slide,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle().copyWith(color: primaryColor),
              ),
              builders: CalendarBuilders(

              ),
              calendarStyle: CalendarStyle(
                  weekendStyle: TextStyle().copyWith(color: primaryColor),
                  todayColor: primaryColor.withOpacity(0.2),
                  todayStyle: TextStyle(
                      color: Colors.black
                  ),
                  selectedColor: primaryColor,
                  outsideDaysVisible: false

              ),
            )
          ],
        ),
      ),
    );
  }
}
