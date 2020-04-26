import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighttime/activities_repository.dart';
import 'package:eighttime/service_locator.dart';
import 'package:eighttime/src/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

@immutable
class WorkEvent {
  final Timestamp date;
  final Timestamp fromTime;
  final Timestamp toTime;
  final String description;
  final GeoPoint geoPoint;
  final Activity activity;
  final String documentUid;
  final String address;

  WorkEvent(this.date, this.fromTime, this.toTime, this.description,
      this.geoPoint, this.activity,
      {this.documentUid, this.address});

  WorkEvent copyWith({Timestamp date,
    Timestamp fromTime,
    Timestamp toTime,
    String description,
    GeoPoint geoPoint,
    Activity activity,
    String documentUid,
    String address}) {
    return WorkEvent(
      date ?? this.date,
      fromTime ?? this.fromTime,
      toTime ?? this.toTime,
      description ?? this.description,
      geoPoint ?? this.geoPoint,
      activity ?? this.activity,
      documentUid: documentUid ?? this.documentUid,
      address: address ?? "",
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
      documentUid.hashCode ^
      address.hashCode;

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
              documentUid == other.documentUid &&
              address == other.address;

  @override
  String toString() {
    return 'WorkEvent { date: $date, fromTime: $fromTime, toTime: $toTime, description: $description, geoPoint: $geoPoint, activity: $activity, documentUid: $documentUid, address: $address}';
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
    var coords = Coordinates(
        entity.geoPoint.latitude, entity.geoPoint.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coords);
    return WorkEvent(
      entity.date,
      entity.fromTime,
      entity.toTime,
      entity.description,
      entity.geoPoint,
      activity,
      documentUid: entity.documentUid,
      address: addresses.first.addressLine,
    );
  }
}
