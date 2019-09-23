import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteConnection {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  get dbPath async {
    String documentsDirectory = await _localPath;
    return p.join(documentsDirectory, "mqtt.db");
  }

  Future<bool> dbExists() async {
    return File(await dbPath).exists();
  }

  initDB() async {
    String path = await dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE places ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT NOT NULL,"
          "icon INTEGER NOT NULL"
          ")");

      await db.execute("CREATE TABLE devices ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "place_id INTEGER NOT NULL,"
          "name TEXT NOT NULL,"
          "icon INTEGER NOT NULL,"
          "FOREIGN KEY (place_id) REFERENCES places (id) ON DELETE CASCADE"
          ")");

      await db.execute("CREATE TABLE plugins ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "device_id INTEGER NOT NULL,"
          "type TEXT NOT NULL,"
          "status INTEGER DEFAULT 0,"
          "config TEXT NOT NULL,"
          "FOREIGN KEY (device_id) REFERENCES devices (id) ON DELETE CASCADE"
          ")");
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}
