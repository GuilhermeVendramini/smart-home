import 'dart:convert';

import 'package:flutter/foundation.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  int id;

  UserModel({
    this.name,
    @required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
