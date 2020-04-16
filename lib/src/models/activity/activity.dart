import 'package:eighttime/main.dart';
import 'package:eighttime/src/entities/activity_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum ColorEnum { red, green, blue, yellow, orange, purple, grey, teal, cyan }

enum IconEnum {
  playArrow,
  stop,
  pause,
  work,
  localCafe,
  memory,
  directionsCar,
  attachMoney,
  build,
  exitToApp,
  code,
  developerMode,
  exitRun,
  error
}

@immutable
class Activity {
  final String name;
  final IconEnum icon;
  final ColorEnum color;
  final int order;
  final String documentUid;

  Activity(this.name, this.icon, this.color, this.order, {this.documentUid});

  Activity copyWith(
      {String name, IconEnum icon, ColorEnum color, int order, String documentUid}) {
    return Activity(
      name ?? this.name,
      icon ?? this.icon,
      color ?? this.color,
      order ?? this.order,
      documentUid: documentUid ?? this.documentUid,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^ icon.hashCode ^ color.hashCode ^ order
          .hashCode ^ documentUid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Activity &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              icon == other.icon &&
              color == other.color &&
              order == other.order &&
              documentUid == other.documentUid;

  @override
  String toString() {
    return 'Activity { name: $name, icon: $icon, color: $color, order: $order, documentUid: $documentUid }';
  }

  ActivityEntity toEntity() {
    return ActivityEntity(name, icon.index, color.index, order, documentUid);
  }

  static Activity fromEntity(ActivityEntity entity) {
    return Activity(
      entity.name,
      IconEnum.values[entity.icon],
      ColorEnum.values[entity.color],
      entity.order,
      documentUid: entity.documentUid,
    );
  }

  /*static Activity fromMap(Map<String, dynamic> map, String documentUid) {
    if (map == null) return null;

    return Activity(
        name: map['name'],
        icon: IconEnum.values[map['icon']],
        color: ColorEnum.values[map['color']],
        order: map['order'],
        documentUid: documentUid);
  }*/

  static enumToIcon([IconEnum icon]) {
    switch (icon) {
      case IconEnum.playArrow:
        return Icons.play_arrow;
      case IconEnum.stop:
        return Icons.stop;
      case IconEnum.pause:
        return Icons.pause;
      case IconEnum.work:
        return Icons.work;
      case IconEnum.localCafe:
        return Icons.local_cafe;
      case IconEnum.memory:
        return Icons.memory;
      case IconEnum.directionsCar:
        return Icons.directions_car;
      case IconEnum.attachMoney:
        return Icons.attach_money;
      case IconEnum.build:
        return Icons.build;
      case IconEnum.exitToApp:
        return Icons.exit_to_app;
      case IconEnum.code:
        return Icons.code;
      case IconEnum.developerMode:
        return Icons.developer_mode;
      case IconEnum.exitRun:
        return MaterialCommunityIcons.exit_run;
      case IconEnum.error:
        return Icons.error;
      default:
        return Icons.error;
    }
  }

  static enumToColor([ColorEnum color]) {
    switch (color) {
      case ColorEnum.red:
        return errorColor;
      case ColorEnum.green:
        return primaryColor;
      case ColorEnum.blue:
        return Colors.blue;
      case ColorEnum.yellow:
        return Colors.yellow;
      case ColorEnum.orange:
        return Colors.orange;
      case ColorEnum.purple:
        return Colors.purple;
      case ColorEnum.grey:
        return Colors.grey;
      case ColorEnum.teal:
        return Colors.teal;
      case ColorEnum.cyan:
        return Colors.cyan;
      default:
        return Colors.red;
    }
  }
}
