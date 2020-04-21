import 'package:eighttime/src/entities/entities.dart';
import 'package:flutter/material.dart';

@immutable
class WorkEvent {
  final DateTime date;
  final DateTime fromTime;
  final DateTime toTime;
  final String description;
  final String activityUid;
  final String documentUid;

  WorkEvent(
      this.date, this.fromTime, this.toTime, this.description, this.activityUid,
      {this.documentUid});

  WorkEvent copyWith(
      {DateTime date,
      DateTime fromTime,
      DateTime toTime,
      String description,
      String activityUid,
      String documentUid}) {
    return WorkEvent(
      date ?? this.date,
      fromTime ?? this.fromTime,
      toTime ?? this.toTime,
      description ?? this.description,
      activityUid ?? this.activityUid,
      documentUid: documentUid ?? this.documentUid,
    );
  }

  @override
  int get hashCode =>
      date.hashCode ^
      fromTime.hashCode ^
      toTime.hashCode ^
      description.hashCode ^
      activityUid.hashCode ^
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
          activityUid == other.activityUid &&
          documentUid == other.documentUid;

  @override
  String toString() {
    return 'WorkEvent { date: $date, fromTime: $fromTime, toTime: $toTime, description: $description, activityUid: $activityUid, documentUid: $documentUid }';
  }

  WorkEventEntity toEntity() {
    return WorkEventEntity(
        date, fromTime, toTime, description, activityUid, documentUid);
  }

  static WorkEvent fromEntity(WorkEventEntity entity) {
    return WorkEvent(
      entity.date,
      entity.fromTime,
      entity.toTime,
      entity.description,
      entity.activityUid,
      documentUid: entity.documentUid,
    );
  }
}
