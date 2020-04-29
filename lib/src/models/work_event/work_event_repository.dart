import 'package:eighttime/src/models/work_event/work_event.dart';

abstract class WorkEventRepository {
  Future<int> workEventCount();

  Future<void> addNewWorkEvent(WorkEvent workEvent);

  Future<void> deleteWorkEvent(WorkEvent workEvent);

  Stream<List<WorkEvent>> workEvents();

  Future<WorkEvent> getWorkEvent(String workEventUid);

  Future<void> updateWorkEvent(WorkEvent workEvent);

  Future<void> updateWorkEvents(List<WorkEvent> update);
}
