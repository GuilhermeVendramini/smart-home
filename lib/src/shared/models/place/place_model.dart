import 'package:flutter/foundation.dart';

class PlaceModel {
  int id;
  String name;
  int icon;

  PlaceModel({
    this.id,
    @required this.name,
    @required this.icon,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}
