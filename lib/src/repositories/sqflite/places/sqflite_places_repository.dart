import '../../../shared/models/place/place_model.dart';
import '../sqflite_connection.dart';

class SQFLitePlacesRepository extends SQFLiteConnection {
  Future<List<PlaceModel>> getPlaces() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('places');

    return result.map((it) => PlaceModel.fromJson(it)).toList();
  }

  Future<PlaceModel> createPlace(PlaceModel place) async {
    final db = await database;
    int id = await db.insert('places', place.toJson());

    return PlaceModel(id: id, name: place.name, icon: place.icon);
  }

  Future<PlaceModel> updatePlace(PlaceModel place) async {
    final db = await database;
    int id = await db.update('places', place.toJson(),
        where: 'id = ?', whereArgs: [place.id]);

    return PlaceModel(id: id, name: place.name, icon: place.icon);
  }

  Future<bool> deletePlace(int id) async {
    final db = await database;
    int result = await db.delete('places', where: 'id = ?', whereArgs: [id]);

    if (result != null && result > 0) {
      return true;
    }

    return false;
  }
}
