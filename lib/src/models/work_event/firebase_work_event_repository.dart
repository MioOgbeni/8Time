import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/src/entities/entities.dart';
import 'package:eighttime/src/models/work_event/work_event.dart';
import 'package:eighttime/src/models/work_event/work_event_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseWorkEventRepository implements WorkEventRepository {
  CollectionReference workEventCollection;

  FirebaseWorkEventRepository();

  Future<void> setCollectionReference({String userUid}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    workEventCollection = Firestore.instance
        .collection('users')
        .document(userUid ?? user.uid)
        .collection('workEvents');
  }

  @override
  Future<int> workEventCount() async {
    await setCollectionReference();
    QuerySnapshot qs = await workEventCollection.getDocuments();
    qs.documents.length;
    return qs.documents.length;
  }

  @override
  Future<void> addNewWorkEvent(WorkEvent workEvent) {
    return workEventCollection.add(workEvent.toEntity().toDocument());
  }

  @override
  Future<void> deleteWorkEvent(WorkEvent workEvent) {
    return workEventCollection.document(workEvent.documentUid).delete();
  }

  @override
  Stream<List<WorkEvent>> workEvents() {
    return workEventCollection.snapshots().asyncMap((snapshot) {
      return Future.wait(snapshot.documents.map((doc) async {
        var workEventEntity = WorkEventEntity.fromSnapshot(doc);
        return await WorkEvent.fromEntity(workEventEntity);
      }));
    });
  }

  @override
  Future<WorkEvent> getWorkEvent(String workEventUid) async {
    DocumentSnapshot doc =
        await workEventCollection.document(workEventUid).get();
    return WorkEvent.fromEntity(WorkEventEntity.fromSnapshot(doc));
  }

  @override
  Future<void> updateWorkEvent(WorkEvent update) {
    return workEventCollection
        .document(update.documentUid)
        .updateData(update.toEntity().toDocument());
  }
}
