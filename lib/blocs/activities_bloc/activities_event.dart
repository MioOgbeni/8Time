import 'package:eighttime/activities_repository.dart';
import 'package:equatable/equatable.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object> get props => [];
}

class LoadActivities extends ActivitiesEvent {}

class AddActivity extends ActivitiesEvent {
  final Activity activity;

  const AddActivity(this.activity);

  @override
  List<Object> get props => [activity];

  @override
  String toString() => 'AddActivity { activity: $activity }';
}

class UpdateActivity extends ActivitiesEvent {
  final Activity activity;

  const UpdateActivity(this.activity);

  @override
  List<Object> get props => [activity];

  @override
  String toString() => 'UpdateActivity { activity: $activity }';
}

class UpdateActivities extends ActivitiesEvent {
  final List<Activity> activities;

  const UpdateActivities(this.activities);

  @override
  List<Object> get props => [activities];

  @override
  String toString() => 'UpdateActivities { activities: $activities }';
}

class DeleteActivity extends ActivitiesEvent {
  final Activity activity;

  const DeleteActivity(this.activity);

  @override
  List<Object> get props => [activity];

  @override
  String toString() => 'DeleteActivity { activity: $activity }';
}

class ActivitiesUpdated extends ActivitiesEvent {
  final List<Activity> activities;

  const ActivitiesUpdated(this.activities);

  @override
  List<Object> get props => [activities];
}
