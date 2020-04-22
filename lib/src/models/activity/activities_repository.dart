import 'dart:async';

import 'package:eighttime/activities_repository.dart';

abstract class ActivitiesRepository {
  Future<int> activitiesCount();

  Future<void> addNewActivity(Activity activity);

  Future<void> deleteActivity(Activity activity);

  Stream<List<Activity>> activities();

  Future<Activity> getActivity(String activityUid);

  Future<void> updateActivity(Activity activity);
}
