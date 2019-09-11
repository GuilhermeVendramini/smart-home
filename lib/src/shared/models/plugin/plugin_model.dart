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

  PluginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    deviceId = json['device_id'];
    config = json['config'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['device_id'] = this.deviceId;
    data['config'] = this.config;
    return data;
  }
}
