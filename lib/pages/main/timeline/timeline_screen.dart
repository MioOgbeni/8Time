import 'dart:math';

import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/work_events_bloc/bloc.dart';
import 'package:eighttime/main.dart';
import 'package:eighttime/pages/main/loading_indicator.dart';
import 'package:eighttime/pages/main/timeline/timeline_list.dart';
import 'package:eighttime/pages/main/timeline/workEventEditForm.dart';
import 'package:eighttime/utils/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    BlocProvider.of<WorkEventsBloc>(context).add(
        LoadWorkEvents(currentDate: DateUtil.nowOnlyDay()));
  }

  void goToToday() {
    print("goToToday");
    DateTime normDateTime = DateUtil.nowOnlyDay();
    BlocProvider.of<WorkEventsBloc>(context)
        .add(LoadWorkEvents(currentDate: normDateTime));

    setState(() {
      _calendarController.setSelectedDay(normDateTime, animate: true);
    });
  }

  void someDaySelected(DateTime date) {
    print("selected date: $date");
    DateTime normDateTime = DateUtil.nowOnlyDay(now: date);
    print(normDateTime);
    BlocProvider.of<WorkEventsBloc>(context)
        .add(LoadWorkEvents(currentDate: normDateTime));

    setState(() {
      _calendarController.setSelectedDay(normDateTime, animate: true);
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
              child: BlocBuilder<WorkEventsBloc, WorkEventsState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is WorkEventsLoading) {
                    return LoadingIndicator();
                  }
                  if (state is WorkEventsLoaded) {
                    List<WorkEvent> sortedList = state.workEvents;
                    sortedList.sort((a, b) => a.fromTime.compareTo(b.fromTime));
                    return TimelineList(workEvents: sortedList);
                  }
                },
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => WorkEventEditForm()));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  final List<String> activitiesUid = <String>[
    "lm89hUiIcAD6BJ6D1i0x",
    "Ur4AgshvUh8jvDhhIBKz",
    "Up6I8KlHCnDwveedwom1",
    "KiDEuTBDjdv8YSn3mRJz",
    "5wIyDr7gGBnefe1Il9GX"
  ];
  final Random r = Random();
}
