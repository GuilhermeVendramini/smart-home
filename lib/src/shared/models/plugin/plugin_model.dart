import 'dart:convert';

import 'package:flutter/foundation.dart';

class PluginModel {
  int id;
  String type;
  bool status;
  int deviceId;
  Map<String, dynamic> config;

  PluginModel(
      {this.id,
      @required this.type,
      this.status,
      @required this.deviceId,
      @required this.config});

  factory PluginModel.fromJson(Map<String, dynamic> json) => new PluginModel(
        id: json["id"],
        type: json["type"],
        deviceId: json["device_id"],
        config: jsonDecode(json["config"]),
        status: json["status"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "device_id": deviceId,
        "config": jsonEncode(this.config).toString(),
        "status": status,
      };
}
