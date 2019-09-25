import 'package:flutter/foundation.dart';

import '../../../shared/models/device/device_model.dart';
import '../sqflite_connection.dart';

class SQFLiteDevicesRepository extends SQFLiteConnection {
  Future<List<DeviceModel>> getDevices({@required int placeId}) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('devices', where: 'place_id = ?', whereArgs: [placeId]);

    return result.map((it) => DeviceModel.fromJson(it)).toList();
  }

  Future<DeviceModel> createDevice(DeviceModel device) async {
    final db = await database;
    int id = await db.insert('devices', device.toJson());

    return DeviceModel(
        id: id, name: device.name, icon: device.icon, placeId: device.placeId);
  }

  Future<DeviceModel> updateDevice(DeviceModel device) async {
    final db = await database;
    int id = await db.update('devices', device.toJson(),
        where: 'id = ?', whereArgs: [device.id]);

    return DeviceModel(
      id: id,
      name: device.name,
      icon: device.icon,
      placeId: device.placeId,
    );
  }

  Future<bool> deleteDevice(int id) async {
    final db = await database;
    int result = await db.delete('devices', where: 'id = ?', whereArgs: [id]);

    if (result != null && result > 0) {
      return true;
    }

    return false;
  }
}
