import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/blocs/activities_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  StreamSubscription _activitiesSubscription;
  final FirebaseActivitiesRepository firebaseActivitiesRepository;

  ActivitiesBloc({@required this.firebaseActivitiesRepository});

  @override
  ActivitiesState get initialState => ActivitiesLoading();

  @override
  Stream<ActivitiesState> mapEventToState(ActivitiesEvent event) async* {
    if (event is LoadActivities) {
      yield* _mapLoadActivitiesToState();
    } else if (event is AddActivity) {
      yield* _mapAddActivityToState(event);
    } else if (event is UpdateActivity) {
      yield* _mapUpdateActivityToState(event);
    } else if (event is UpdateActivities) {
      yield* _mapUpdateActivitiesToState(event);
    } else if (event is DeleteActivity) {
      yield* _mapDeleteActivityToState(event);
    } else if (event is ActivitiesUpdated) {
      yield* _mapActivitiesUpdateToState(event);
    }
  }

  Stream<ActivitiesState> _mapLoadActivitiesToState() async* {
    _activitiesSubscription?.cancel();
    _activitiesSubscription = firebaseActivitiesRepository.activities().listen(
          (activities) => add(ActivitiesUpdated(activities)),
        );
  }

  Stream<ActivitiesState> _mapAddActivityToState(AddActivity event) async* {
    firebaseActivitiesRepository.addNewActivity(event.activity);
  }

  Stream<ActivitiesState> _mapUpdateActivityToState(
      UpdateActivity event) async* {
    firebaseActivitiesRepository.updateActivity(event.activity);
  }

  Stream<ActivitiesState> _mapUpdateActivitiesToState(
      UpdateActivities event) async* {
    event.activities
        .forEach((item) => firebaseActivitiesRepository.updateActivity(item));
  }

  Stream<ActivitiesState> _mapDeleteActivityToState(
      DeleteActivity event) async* {
    firebaseActivitiesRepository.deleteActivity(event.activity);
  }

  Stream<ActivitiesState> _mapActivitiesUpdateToState(
      ActivitiesUpdated event) async* {
    yield ActivitiesLoaded(event.activities);
  }

  @override
  Future<void> close() {
    _activitiesSubscription?.cancel();
    return super.close();
  }
}
