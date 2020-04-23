import 'package:eighttime/work_events_repository.dart';
import 'package:equatable/equatable.dart';

abstract class WorkEventsEvent extends Equatable {
  const WorkEventsEvent();

  @override
  List<Object> get props => [];
}

class LoadWorkEvents extends WorkEventsEvent {}

class AddWorkEvent extends WorkEventsEvent {
  final WorkEvent workEvent;

  const AddWorkEvent(this.workEvent);

  @override
  List<Object> get props => [workEvent];

  @override
  String toString() => 'AddWorkEvent { workEvent: $workEvent }';
}

class UpdateWorkEvent extends WorkEventsEvent {
  final WorkEvent workEvent;

  const UpdateWorkEvent(this.workEvent);

  @override
  List<Object> get props => [workEvent];

  @override
  String toString() => 'UpdateWorkEvent { workEvent: $workEvent }';
}

class UpdateWorkEvents extends WorkEventsEvent {
  final List<WorkEvent> workEvents;

  const UpdateWorkEvents(this.workEvents);

  @override
  List<Object> get props => [workEvents];

  @override
  String toString() => 'UpdateWorkEvents { workEvents: $workEvents }';
}

class DeleteWorkEvent extends WorkEventsEvent {
  final WorkEvent workEvent;

  const DeleteWorkEvent(this.workEvent);

  @override
  List<Object> get props => [workEvent];

  @override
  String toString() => 'DeleteWorkEvent { workEvent: $workEvent }';
}

class WorkEventsUpdated extends WorkEventsEvent {
  final List<WorkEvent> workEvents;

  const WorkEventsUpdated(this.workEvents);

  @override
  List<Object> get props => [workEvents];
}
