import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final String name;
  final int icon;
  final int color;
  final int order;
  final String documentUid;

  const ActivityEntity(
      this.name, this.icon, this.color, this.order, this.documentUid);

  Map<String, Object> toJson() {
    return {
      "name": name,
      "icon": icon,
      "color": color,
      "order": order,
      "documentUid": documentUid,
    };
  }

  @override
  List<Object> get props => [name, icon, color, order, documentUid];

  @override
  String toString() {
    return 'ActivityEntity { name: $name, icon: $icon, color: $color, order: $order, documentUid: $documentUid }';
  }

  static ActivityEntity fromJson(Map<String, Object> json) {
    return ActivityEntity(
      json["name"] as String,
      json["icon"] as int,
      json["color"] as int,
      json["order"] as int,
      json["documentUid"] as String,
    );
  }

  static ActivityEntity fromSnapshot(DocumentSnapshot snap) {
    return ActivityEntity(
      snap.data['name'],
      snap.data['icon'],
      snap.data['color'],
      snap.data['order'],
      snap.documentID,
    );
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "icon": icon,
      "color": color,
      "order": order,
      "documentUid": documentUid,
    };
  }
}
