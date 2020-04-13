import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/models/activity.dart';

class DatabaseService {
  String userUid;
  CollectionReference activitiesCollection;
  CollectionReference userCollection;

  DatabaseService(String userUid) {
    this.userUid = userUid;
    this.activitiesCollection = Firestore.instance
        .collection('userData')
        .document(userUid)
        .collection('activities');
    this.userCollection = Firestore.instance.collection('userData');
  }

  void initialActivitiesCreate() async {
    QuerySnapshot ds = await userCollection
        .document(userUid)
        .collection('activities')
        .getDocuments();

    if (ds.documents.length <= 0) {
      DatabaseService(userUid).addActivity(Activity(
          name: 'Work', icon: IconEnum.work, color: ColorEnum.green, order: 0));
      DatabaseService(userUid).addActivity(Activity(
          name: 'End work',
          icon: IconEnum.exitToApp,
          color: ColorEnum.red,
          order: 1));
    }
  }

  // add activity
  Future addActivity(Activity activity) async {
    QuerySnapshot ds = await userCollection
        .document(userUid)
        .collection('activities')
        .getDocuments();
    activity.order = ds.documents.length;
    return await activitiesCollection.add(activity.toMap());
  }

  // edit activity
  Future editActivity(Activity activity) async {
    return await activitiesCollection
        .document(activity.documentUid)
        .updateData(activity.toMap());
  }

  // delete activity
  Future deleteActivity(Activity activity) async {
    var activitiesBatch = activitiesCollection.firestore.batch();
    try {
      var docReference = activitiesCollection.document(activity.documentUid);

      activitiesBatch.delete(docReference);

      activitiesBatch.commit();
    } catch (e) {
      print(e);
    }
  }

  // activities list from snapshot
  List<Activity> _activitiesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((snapshot) => Activity.fromMap(snapshot.data, snapshot.documentID))
        .toList();
  }

  // get activities stream
  Stream<List<Activity>> get activities {
    return activitiesCollection.snapshots().map(_activitiesListFromSnapshot);
  }
}
