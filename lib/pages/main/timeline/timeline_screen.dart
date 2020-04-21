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
      backgroundColor: Colors.white,
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
              child: Container(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
