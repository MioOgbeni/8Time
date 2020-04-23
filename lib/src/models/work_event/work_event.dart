import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/service_locator.dart';
import 'package:eighttime/src/entities/entities.dart';
import 'package:flutter/material.dart';

@immutable
class WorkEvent {
  final DateTime date;
  final DateTime fromTime;
  final DateTime toTime;
  final String description;
  final GeoPoint geoPoint;
  final Activity activity;
  final String documentUid;

  WorkEvent(this.date, this.fromTime, this.toTime, this.description,
      this.geoPoint, this.activity,
      {this.documentUid});

  WorkEvent copyWith({DateTime date,
    DateTime fromTime,
    DateTime toTime,
    String description,
    GeoPoint geoPoint,
    Activity activity,
    String documentUid}) {
    return WorkEvent(
      date ?? this.date,
      fromTime ?? this.fromTime,
      toTime ?? this.toTime,
      description ?? this.description,
      geoPoint ?? this.geoPoint,
      activity ?? this.activity,
      documentUid: documentUid ?? this.documentUid,
    );
  }

  @override
  int get hashCode =>
      date.hashCode ^
      fromTime.hashCode ^
      toTime.hashCode ^
      description.hashCode ^
      geoPoint.hashCode ^
      activity.hashCode ^
      documentUid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WorkEvent &&
              runtimeType == other.runtimeType &&
              date == other.date &&
              fromTime == other.fromTime &&
              toTime == other.toTime &&
              description == other.description &&
              geoPoint == other.geoPoint &&
              activity == other.activity &&
              documentUid == other.documentUid;

  @override
  String toString() {
    return 'WorkEvent { date: $date, fromTime: $fromTime, toTime: $toTime, description: $description, geoPoint: $geoPoint, activity: $activity, documentUid: $documentUid }';
  }

  WorkEventEntity toEntity() {
    return WorkEventEntity(
        date,
        fromTime,
        toTime,
        description,
        geoPoint,
        activity.documentUid,
        documentUid);
  }

  static Future<WorkEvent> fromEntity(WorkEventEntity entity) async {
    Activity activity = await injector
        .get<FirebaseActivitiesRepository>()
        .getActivity(entity.activityUid);
    return WorkEvent(
      entity.date,
      entity.fromTime,
      entity.toTime,
      entity.description,
      entity.geoPoint,
      activity,
      documentUid: entity.documentUid,
    );
  }
}
