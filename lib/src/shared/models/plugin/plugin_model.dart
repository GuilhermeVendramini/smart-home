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

  PluginModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    type = data['type'];
    status = data['status'] == 1 ? true : false;
    deviceId = data['device_id'];
    config = jsonDecode(data['config']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['device_id'] = this.deviceId;
    data['config'] = jsonEncode(this.config);
    return data;
  }
}
