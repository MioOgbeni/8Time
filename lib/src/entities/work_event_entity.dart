import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WorkEventEntity extends Equatable {
  final Timestamp date;
  final Timestamp fromTime;
  final Timestamp toTime;
  final String description;
  final GeoPoint geoPoint;
  final String activityUid;
  final String documentUid;

  const WorkEventEntity(this.date, this.fromTime, this.toTime, this.description,
      this.geoPoint,
      this.activityUid, this.documentUid);

  Map<String, Object> toJson() {
    return {
      "date": date,
      "timeFrom": fromTime,
      "timeTo": toTime,
      "description": description,
      "geoPoint": geoPoint,
      "activityUid": activityUid,
      "documentUid": documentUid,
    };
  }

  @override
  List<Object> get props =>
      [date, fromTime, toTime, description, geoPoint, activityUid, documentUid];

  @override
  String toString() {
    return 'WorkEventEntity { date: $date, timeFrom: $fromTime, timeTo: $toTime, description: $description, geoPoint: $geoPoint, activityUid: $activityUid, documentUid: $documentUid }';
  }

  static WorkEventEntity fromJson(Map<String, Object> json) {
    return WorkEventEntity(
      json["date"] as Timestamp,
      json["timeFrom"] as Timestamp,
      json["timeTo"] as Timestamp,
      json["description"] as String,
      json["geoPoint"] as GeoPoint,
      json["activityUid"] as String,
      json["documentUid"] as String,
    );
  }

  static WorkEventEntity fromSnapshot(DocumentSnapshot snap) {
    return WorkEventEntity(
      snap.data['date'],
      snap.data['timeFrom'],
      snap.data['timeTo'],
      snap.data['description'],
      snap.data['geoPoint'],
      snap.data['activityUid'],
      snap.documentID,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "date": date,
      "timeFrom": fromTime,
      "timeTo": toTime,
      "description": description,
      "geoPoint": geoPoint,
      "activityUid": activityUid,
      "documentUid": documentUid,
    };
  }
}
