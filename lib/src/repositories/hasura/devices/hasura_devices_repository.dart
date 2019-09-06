import 'package:flutter/foundation.dart';

import '../../../shared/models/device/device_model.dart';
import '../hasura_connection.dart';

class HasuraDevicesRepository extends HasuraConnection {
  Future<List<DeviceModel>> getDevices({@required int placeId}) async {
    String query = """
     getDevices(\$place_id:Int!){
      devices(where: {place_id: {_eq: \$place_id}}){
        id
        name
        icon
        place_id
      }
    }
    """;

    Map<String, dynamic> data =
        await hasuraConnect.query(query, variables: {"place_id": placeId});
    List<DeviceModel> devices = [];
    if (data["data"]["devices"].isEmpty) {
      return devices;
    } else {
      data["data"]["devices"].forEach((v) {
        devices.add(new DeviceModel.fromJson(v));
      });
      return devices;
    }
  }

  Future<DeviceModel> createDevice(
      {String name, String icon, int placeId}) async {
    String query = """
      mutation createDevice(\$name:String!, \$icon:String!, \$placeId:Int!) {
        insert_devices(objects: {name: \$name, icon: \$icon, place_id: \$placeId}) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> data = await hasuraConnect.mutation(query,
        variables: {"name": name, "icon": icon, "placeId": placeId});
    int id = data["data"]["insert_devices"]["returning"][0]["id"];
    return DeviceModel(id: id, name: name, icon: icon, placeId: placeId);
  }

  @override
  void dispose() {
    hasuraConnect.dispose();
  }
}
