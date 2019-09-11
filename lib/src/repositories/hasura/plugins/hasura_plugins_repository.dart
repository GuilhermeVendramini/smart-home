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

  @override
  void dispose() {
    hasuraConnect.dispose();
  }
}
