import '../../../shared/models/place/place_model.dart';
import '../hasura_connection.dart';

class HasuraPlacesRepository extends HasuraConnection {
  Future<List<PlaceModel>> getPlaces() async {
    String query = """
     {
      places {
        id
        name
        icon
      }
    }
    """;

    Map<String, dynamic> data = await hasuraConnect.query(query);
    List<PlaceModel> places = [];
    if (data["data"]["places"].isEmpty) {
      return places;
    } else {
      data["data"]["places"].forEach((v) {
        places.add(new PlaceModel.fromJson(v));
      });
      return places;
    }
  }

  Future<PlaceModel> createPlace({String name, int icon}) async {
    String query = """
      mutation createPlace(\$name:String!, \$icon:Int!) {
        insert_places(objects: {name: \$name, icon: \$icon}) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> data = await hasuraConnect
        .mutation(query, variables: {"name": name, "icon": icon});
    int id = data["data"]["insert_places"]["returning"][0]["id"];
    return PlaceModel(id: id, name: name, icon: icon);
  }

  Future<PlaceModel> updatePlace(PlaceModel place) async {
    String query = """
      mutation updatePlace(\$id:Int!, \$name:String!, \$icon:Int!) {
        update_places(where: {id: {_eq: \$id}}, _set: {
          name: \$name,
          icon: \$icon
        }) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> data = await hasuraConnect.mutation(query,
        variables: {"id": place.id, "name": place.name, "icon": place.icon});
    int id = data["data"]["update_places"]["returning"][0]["id"];
    return PlaceModel(id: id, name: place.name, icon: place.icon);
  }

  Future<bool> deletePlace(int id) async {
    String query = """
      mutation deletePlace(\$id:Int!) {
        delete_places(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
      """;

    Map<String, dynamic> data =
        await hasuraConnect.mutation(query, variables: {"id": id});
    int affectedRows = data["data"]["delete_places"]["affected_rows"];
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
