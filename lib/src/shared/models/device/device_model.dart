import 'dart:convert';
import 'package:flutter/foundation.dart';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
  int id;
  String name;
  int icon;

  DeviceModel({
    this.id,
    @required this.name,
    @required this.icon,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => new DeviceModel(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}
