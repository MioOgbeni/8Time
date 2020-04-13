import 'package:eighttime/main.dart';
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

class Activity {
  String name;
  IconEnum icon;
  ColorEnum color;
  int order;
  bool available;
  final String documentUid;

  Activity({this.name, this.icon, this.color, this.order, this.documentUid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon.index,
      'color': color.index,
      'order': order
    };
  }

  static Activity fromMap(Map<String, dynamic> map, String documentUid) {
    if (map == null) return null;

    return Activity(
        name: map['name'],
        icon: IconEnum.values[map['icon']],
        color: ColorEnum.values[map['color']],
        order: map['order'],
        documentUid: documentUid);
  }

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
