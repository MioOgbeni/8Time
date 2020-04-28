import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eighttime/blocs/work_events_bloc/bloc.dart';
import 'package:eighttime/utils/date_util.dart';
import 'package:eighttime/work_events_repository.dart';
import 'package:flutter/cupertino.dart';

class WorkEventsBloc extends Bloc<WorkEventsEvent, WorkEventsState> {
  StreamSubscription _workEventsSubscription;
  final FirebaseWorkEventRepository firebaseWorkEventRepository;

  WorkEventsBloc({@required this.firebaseWorkEventRepository});

  @override
  WorkEventsState get initialState => WorkEventsLoading();

  @override
  Stream<WorkEventsState> mapEventToState(WorkEventsEvent event) async* {
    if (event is LoadWorkEvents) {
      yield* _mapLoadWorkEventsToState(event);
    } else if (event is AddWorkEvent) {
      yield* _mapAddWorkEventToState(event);
    } else if (event is UpdateWorkEvent) {
      yield* _mapUpdateWorkEventToState(event);
    } else if (event is UpdateWorkEvents) {
      yield* _mapUpdateWorkEventsToState(event);
    } else if (event is DeleteWorkEvent) {
      yield* _mapDeleteWorkEventToState(event);
    } else if (event is WorkEventsUpdated) {
      yield* _mapWorkEventsUpdateToState(event);
    }
  }

  Stream<WorkEventsState> _mapLoadWorkEventsToState(
      LoadWorkEvents event) async* {
    await firebaseWorkEventRepository.setCollectionReference();
    _workEventsSubscription?.cancel();
    _workEventsSubscription = firebaseWorkEventRepository.workEvents().listen(
          (workEvents) => add(WorkEventsUpdated(
          workEvents.where((item) => (DateUtil.getDateTimeFromTimestamp(
              item.date).isAtSameMomentAs(event.currentDate))).toList())),
    );
  }

  Stream<WorkEventsState> _mapAddWorkEventToState(AddWorkEvent event) async* {
    firebaseWorkEventRepository.addNewWorkEvent(event.workEvent);
  }

  Stream<WorkEventsState> _mapUpdateWorkEventToState(
      UpdateWorkEvent event) async* {
    firebaseWorkEventRepository.updateWorkEvent(event.workEvent);
  }

  Stream<WorkEventsState> _mapUpdateWorkEventsToState(
      UpdateWorkEvents event) async* {
    event.workEvents
        .forEach((item) => firebaseWorkEventRepository.updateWorkEvent(item));
  }

  Stream<WorkEventsState> _mapDeleteWorkEventToState(
      DeleteWorkEvent event) async* {
    firebaseWorkEventRepository.deleteWorkEvent(event.workEvent);
  }

  Stream<WorkEventsState> _mapWorkEventsUpdateToState(
      WorkEventsUpdated event) async* {
    yield WorkEventsLoaded(event.workEvents);
  }

  @override
  Future<void> close() {
    _workEventsSubscription?.cancel();
    return super.close();
  }
}
