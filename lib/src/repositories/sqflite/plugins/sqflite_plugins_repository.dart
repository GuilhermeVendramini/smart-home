import 'package:flutter/foundation.dart';

import '../../../shared/models/plugin/plugin_model.dart';
import '../sqflite_connection.dart';

class SQFLitePluginsRepository extends SQFLiteConnection {
  Future<PluginModel> savePlugin(PluginModel plugin) async {
    final db = await database;
    int id = await db.insert('plugins', plugin.toJson());

    return PluginModel(
      id: id,
      type: plugin.type,
      status: plugin.status,
      deviceId: plugin.deviceId,
      config: plugin.config,
    );
  }

  Future<List<PluginModel>> getPlugins({@required int deviceId}) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db
        .query('plugins', where: 'device_id = ?', whereArgs: [deviceId]);

    return result.map((it) => PluginModel.fromJson(it)).toList();
  }

  Future<PluginModel> updatePlugin(PluginModel plugin) async {
    final db = await database;
    int id = await db.update('plugins', plugin.toJson(),
        where: 'id = ?', whereArgs: [plugin.id]);

    return PluginModel(
      id: id,
      type: plugin.type,
      status: plugin.status,
      deviceId: plugin.deviceId,
      config: plugin.config,
    );
  }
}
