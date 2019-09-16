import 'dart:convert';

import 'package:flutter/foundation.dart';
// import '../../models/device/device_model.dart';

PlaceModel placeModelFromJson(String str) =>
    PlaceModel.fromJson(json.decode(str));

String placeModelToJson(PlaceModel data) => json.encode(data.toJson());

class PlaceModel {
  int id;
  String name;
  int icon;

  // List<DeviceModel> devices;

  PlaceModel({
    this.id,
    @required this.name,
    @required this.icon,
    // this.devices,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
/*    List<DeviceModel> devices = [];

    if (json['devices'] != null) {
      json['devices'].forEach((v) {
        devices.add(new DeviceModel.fromJson(v));
      });
    }*/

    return PlaceModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      // devices: devices,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
/*    data['devices'] = [];
    if (devices != null) {
      data['devices'] = this.devices.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}
