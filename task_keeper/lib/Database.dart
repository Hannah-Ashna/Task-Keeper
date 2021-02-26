import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/List.dart';

class DatabaseTool {

  Future<Database> database() async{
    return openDatabase(
        join(await getDatabasesPath(), 'toDo.db'),

        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE list(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
          );
        },
        version: 1,
    );
  }

  Future<void> insertList(List list) async{
    Database _db = await database();
    await _db.insert('list', list.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}