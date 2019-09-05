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

  Future<PlaceModel> createPlaces({String name, String icon}) async {
    String query = """
      mutation createPlaces(\$name:String!, \$icon:String!) {
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

  @override
  void dispose() {
    hasuraConnect.dispose();
  }
}
