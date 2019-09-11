import 'package:flutter/foundation.dart';
import '../../../shared/models/plugin/plugin_model.dart';
import '../hasura_connection.dart';

class HasuraPluginsRepository extends HasuraConnection {
  Future<PluginModel> savePlugin(
      {String type,
      bool status,
      int deviceId,
      Map<String, dynamic> config}) async {
    String query = """
      mutation savePlugin(\$type:String!, \$status:Boolean!, \$deviceId:Int!, \$config:jsonb!) {
        insert_plugins(objects: {type: \$type, status: \$status, device_id: \$deviceId, config: \$config}) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> data = await hasuraConnect.mutation(query, variables: {
      "type": type,
      "status": status,
      "deviceId": deviceId,
      "config": config,
    });
    int id = data["data"]["insert_plugins"]["returning"][0]["id"];
    return PluginModel(
      id: id,
      type: type,
      status: status,
      deviceId: deviceId,
      config: config,
    );
  }

  Future<List<PluginModel>> getPlugins({@required int deviceId}) async {
    String query = """
     getPlugins(\$device_id:Int!){
      plugins(where: {device_id: {_eq: \$device_id}}){
        id
        type
        status
        device_id
        config
      }
    }
    """;

    Map<String, dynamic> data =
    await hasuraConnect.query(query, variables: {"device_id": deviceId});
    List<PluginModel> plugins = [];
    if (data["data"]["plugins"].isEmpty) {
      return plugins;
    } else {
      data["data"]["plugins"].forEach((v) {
        plugins.add(new PluginModel.fromJson(v));
      });
      return plugins;
    }
  }

  @override
  void dispose() {
    hasuraConnect.dispose();
  }
}
