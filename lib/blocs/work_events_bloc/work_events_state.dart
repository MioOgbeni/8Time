import 'package:eighttime/src/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class WorkEventsState extends Equatable {
  const WorkEventsState();

  @override
  List<Object> get props => [];
}

class WorkEventsLoading extends WorkEventsState {}

class WorkEventsLoaded extends WorkEventsState {
  final List<WorkEvent> workEvents;

  const WorkEventsLoaded([this.workEvents = const []]);

  @override
  List<Object> get props => [workEvents];

  @override
  String toString() => 'WorkEventsLoaded { workEvents: $workEvents }';
}

class WorkEventsNotLoaded extends WorkEventsState {}
