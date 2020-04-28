import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static List<DateTime> getDisplayedWeekDays(DateTime todayDateTime) {
    List<DateTime> currentWeek = new List<DateTime>();
    int dayOfWeek = todayDateTime.weekday;

    for (int i = 1; i < dayOfWeek; i++) {
      currentWeek
          .add(todayDateTime.subtract(new Duration(days: (dayOfWeek - i))));
    }

    for (int i = dayOfWeek; i <= 7; i++) {
      currentWeek.add(todayDateTime.add(new Duration(days: (i - dayOfWeek))));
    }

    return currentWeek;
  }

  static DateTime getDateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch);
  }

  static String getTimeFromDateTime(DateTime dateTime) {
    return DateFormat("HH:mm").format(dateTime);
  }

  static String getDayFromDateTime(DateTime dateTime) {
    return DateFormat("dd.MM.yyyy").format(dateTime);
  }

  static String getDifferenceBetweenTwoTimes(DateTime from, DateTime to) {
    if (from.isAfter(to)) {
      from = from.subtract(Duration(days: 1));
      return formatTime(from.difference(to).abs());
    } else {
      return formatTime(to.difference(from));
    }
  }

  static String formatTime(Duration duration) {
    return [duration.inHours, duration.inMinutes].map((seg) =>
        seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }

  static DateTime now({DateTime now}) {
    if (now == null) {
      now = DateTime.now();
    }
    int seconds = now.second;
    int milSeconds = now.millisecond;
    int microSeconds = now.microsecond;
    now = now.subtract(Duration(microseconds: microSeconds));
    now = now.subtract(Duration(milliseconds: milSeconds));
    now = now.subtract(Duration(seconds: seconds));
    print("DateTime.nowOnlyDay(): $now");
    return now;
  }

  static DateTime nowOnlyDay({DateTime now}) {
    if (now == null) {
      now = DateTime.now();
    }
    var temp = now.millisecondsSinceEpoch;
    now = DateTime.fromMillisecondsSinceEpoch(temp);
    int hours = now.hour;
    int minutes = now.minute;
    int seconds = now.second;
    int milSeconds = now.millisecond;
    int microSeconds = now.microsecond;
    now = now.subtract(Duration(microseconds: microSeconds));
    now = now.subtract(Duration(milliseconds: milSeconds));
    now = now.subtract(Duration(seconds: seconds));
    now = now.subtract(Duration(minutes: minutes));
    now = now.subtract(Duration(hours: hours));
    print("DateTime.nowOnlyDay(): $now");
    return now;
  }
}
