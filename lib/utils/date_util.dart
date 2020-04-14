class DateUtil {
  List<DateTime> getDisplayedWeekDays(DateTime todayDateTime) {
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
}
