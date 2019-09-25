import 'package:flutter/foundation.dart';

class DeviceModel {
  int id;
  String name;
  int icon;
  int placeId;

  DeviceModel({
    this.id,
    @required this.name,
    @required this.icon,
    @required this.placeId,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => new DeviceModel(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        placeId: json["place_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "place_id": placeId,
      };
}
