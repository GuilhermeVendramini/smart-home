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

  Future<DeviceModel> createDevice({String name, int icon, int placeId}) async {
    String query = """
      mutation createDevice(\$name:String!, \$icon:Int!, \$placeId:Int!) {
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

  Future<DeviceModel> updateDevice(DeviceModel device) async {
    String query = """
      mutation updateDevice(\$id:Int!, \$name:String!, \$icon:Int!, \$placeId:Int!) {
        update_devices(where: {id: {_eq: \$id}}, _set: {
          name: \$name,
          icon: \$icon,
          place_id: \$placeId
        }) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> data = await hasuraConnect.mutation(query, variables: {
      "id": device.id,
      "name": device.name,
      "icon": device.icon,
      "placeId": device.placeId
    });
    int id = data["data"]["update_devices"]["returning"][0]["id"];
    return DeviceModel(
      id: id,
      name: device.name,
      icon: device.icon,
      placeId: device.placeId,
    );
  }

  Future<bool> deleteDevice(int id) async {
    String query = """
      mutation deleteDevice(\$id:Int!) {
        delete_devices(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
      """;

    Map<String, dynamic> data =
        await hasuraConnect.mutation(query, variables: {"id": id});
    int affectedRows = data["data"]["delete_devices"]["affected_rows"];
    if (affectedRows > 0) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    hasuraConnect.dispose();
  }
}
