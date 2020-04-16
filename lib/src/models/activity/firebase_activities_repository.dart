import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/src/entities/activity_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseActivitiesRepository implements ActivitiesRepository {
  CollectionReference activityCollection;

  FirebaseActivitiesRepository();

  Future<void> setCollectionReference() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    activityCollection =
        Firestore.instance.collection('users').document(user.uid).collection(
            'activities');
  }

  @override
  Future<int> activitiesCount() async {
    QuerySnapshot qs = await activityCollection.getDocuments();
    qs.documents.length;
    return qs.documents.length;
  }

  @override
  Future<void> addNewActivity(Activity activity) {
    return activityCollection.add(activity.toEntity().toDocument());
  }

  @override
  Future<void> deleteActivity(Activity activity) async {
    return activityCollection.document(activity.documentUid).delete();
  }

  @override
  Stream<List<Activity>> activities() {
    return activityCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Activity.fromEntity(ActivityEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateActivity(Activity update) {
    return activityCollection
        .document(update.documentUid)
        .updateData(update.toEntity().toDocument());
  }
}
